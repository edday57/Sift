[{
    $lookup: {
     from: 'likes',
     localField: '_id',
     foreignField: 'listing',
     as: 'likes'
    }
   }, {
    $addFields: {
     isLiked: {
      $in: [
       ObjectId('63c8279a5b061b24d6897c5c'),
       '$likes.user'
      ]
     }
    }
   }]