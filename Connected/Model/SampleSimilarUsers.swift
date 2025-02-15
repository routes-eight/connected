//
//  sampleSimilarUsers.swift
//  Connected
//
//  Created by 정근호 on 8/21/24.
//

import Foundation


struct sample {
    let sampleSimilarUsers: [User] = [
        User(
            id: "4RiOmoSZXAhV3bMAZwh8T5D6ywQ2",
            name: "Kevin",
            gender: "male",
            interests: ["농구", "축구", "헬스"],
            selectedColor: "빨간색",
            selectedMBTI: "ENTP",
            musicGenres: ["POP", "HipHop"],
            movieGenres: ["스릴러", "액션"],
            profileImageUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
        ),
        
        User(
            id: "7vU5pIhPVkPtARu4TFf86bOamX82",
            name: "Ann",
            gender: "female",
            interests: ["드라이브", "축구", "헬스"],
            selectedColor: "파란색",
            selectedMBTI: "INTP",
            musicGenres: ["EDM", "HipHop"],
            movieGenres: ["공포", "판타지"],
            profileImageUrl:  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            
        ),
        
        User(
            id: "9N9M9MtmfjR3Y13MMzJy7edNZu03",
            name: "John",
            gender: "male",
            interests: ["독서", "수영", "헬스"],
            selectedColor: "검은색",
            selectedMBTI: "ISTP",
            musicGenres: ["R&B", "HipHop"],
            movieGenres: ["SF", "판타지"],
            profileImageUrl: "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"
            
        )
        // 추가 샘플 사용자들...
    ]
}
