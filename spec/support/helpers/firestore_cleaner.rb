module FirestoreCleaner
  # @param collection_path [String]
  # @param batch_size [Integer]
  def delete_collection(collection_path, batch_size: 500)
    firestore = Google::Cloud::Firestore.new

    collection_ref = firestore.col(collection_path)
    query = collection_ref.limit(batch_size)

    loop do
      query_snapshot = query.get
      break if query_snapshot.count == 0

      firestore.batch do |b|
        query_snapshot.each do |doc|
          b.delete(doc.ref)
        end
      end
    end
  end
end
