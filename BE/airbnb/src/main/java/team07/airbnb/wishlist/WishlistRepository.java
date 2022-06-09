package team07.airbnb.wishlist;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface WishlistRepository extends JpaRepository<Wishlist, Long> {
    @Query("select w from Wishlist w join fetch w.room where w.user.userId=:userId")
    List<Wishlist> findByUserId(@Param("userId") Long userId);

    @Query("select w from Wishlist w join fetch w.user join fetch w.room where w.user.userId=:userId")
    List<Wishlist> findAllByUserId(Long userId);

    @Query("select w from Wishlist w join fetch w.room r join fetch r.images i where w.user.userId=:userId and i.imageOrder = 1")
    List<Wishlist> findWishlistWithRoomAndImageOrderEqualsOneByUserId(@Param("userId") Long userId);
}
