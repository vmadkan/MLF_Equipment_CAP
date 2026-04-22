const cds = require('@sap/cds')

module.exports = cds.service.impl(async function () {
  if (this.name !== 'DMSService') return

  console.log('✅ Handler bound to', this.name)

  this.on('GetFolderContent', async (req) => {
    try {
      const dms = await cds.connect.to('DMS')

      const folderPath = 'OEMFolder_1'
      const EquipmentID = (req.data?.EquipmentID || '').trim()
      const equip = EquipmentID.toLowerCase()

      const response = await dms.send({
        method: 'GET',
        path: `/${folderPath}?cmisselector=children&succinct=true`,
        headers: {
          Accept: 'application/json'
        }
      })

      console.log('DMS raw response:', JSON.stringify(response, null, 2))

      const objects = response?.objects || []

      const results = objects
        .map((entry) => {
          const obj = entry?.object || {}
          const props = obj?.succinctProperties || obj?.properties || {}

          const getVal = (key) => {
            const v = props[key]
            if (v && typeof v === 'object' && 'value' in v) return v.value
            return v ?? null
          }

          const baseType = getVal('cmis:baseTypeId')
          const name = getVal('cmis:name')

          return {
            objectId: getVal('cmis:objectId'),
            name,
            type: baseType === 'cmis:folder' ? 'folder' : 'document',
            mimeType: getVal('cmis:contentStreamMimeType'),
            size: getVal('cmis:contentStreamLength') || 0,
            createdAt: getVal('cmis:creationDate'),
            createdBy: getVal('cmis:createdBy')
          }
        })
        .filter((item) =>
          item.type === 'document' &&
          item.name &&
          (!equip || item.name.toLowerCase().includes(equip))
        )

      return { value: results }
    } catch (error) {
      console.error('DMS GetFolderContent failed:', error)

      req.reject(
        error.statusCode || 500,
        error.message || 'Failed to fetch folder content from DMS'
      )
    }
  })
})