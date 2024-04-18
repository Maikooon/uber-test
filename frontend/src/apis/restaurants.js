import axios from 'axios';
import { restaurantsIndex } from '../urls/index'

export const fetchRestaurants = () => {
    return axios.get(restaurantsIndex)
        .then(res => {
            //response の中身だけを返す
            return res.data
        })
        // 例外処理を行う
        .catch((e) => console.error(e))
}


export const RestaurantsContents = () => {
    return (
        <div>
            {/* コンポーネントの内容 */}
        </div>
    );
};