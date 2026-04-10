
const cds = require('@sap/cds')

module.exports = cds.service.impl(function () {

  if (this.name !== 'DMSService') return
  console.log('✅ Handler bound to', this.name)

  this.on('GetFolderContent', async (req) => {
    const { repositoryId, folderPath } = req.data

    if (!repositoryId || !folderPath) {
      req.reject(400, 'repositoryId and folderPath are required')
    }


    const normalizedPath = folderPath.startsWith('/root')
      ? folderPath
      : `/root${folderPath.startsWith('/') ? '' : '/'}${folderPath}`

    const dms = await cds.connect.to('DMS')

    const cmisUrl =
      `/browser/${repositoryId}${normalizedPath}?cmisselector=children`

    // ✅ CAP-native call (no Cloud SDK)
    const response = await dms.get(cmisUrl, {
      headers: { Accept: 'application/json' }
    })

    const objects = response?.objects ?? []

    return objects.map(o => {
      const p = o.object.properties

      return {
        objectId  : p['cmis:objectId']?.value,
        name      : p['cmis:name']?.value,
        type      : p['cmis:baseTypeId']?.value === 'cmis:folder'
                      ? 'folder'
                      : 'document',
        mimeType  : p['cmis:contentStreamMimeType']?.value ?? null,
        size      : p['cmis:contentStreamLength']?.value ?? 0,
        createdAt : p['cmis:creationDate']?.value,
        createdBy : p['cmis:createdBy']?.value
      }
    })
  })
})
