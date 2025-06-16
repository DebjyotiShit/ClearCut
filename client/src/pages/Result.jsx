import React, { useContext } from 'react';
import { assets } from '../assets/assets';
import { AppContext } from '../context/AppContext';
import { Link } from 'react-router-dom';


const Result = () => {

    const {resultImage, image} = useContext(AppContext) 

    return(
        <div className='mx-4 my-3 lg:mx-44 mt-14 min-h-[75vh]'>

            <div className='px-8 py-6 bg-white rounded-lg drop-shadow-sm'>
                <div className='flex flex-col grid-cols-2 gap-8 sm:grid'>
                    <div>
                        <p className='mb-2 font-semibold text-gray-600'>Original</p>
                        <img className='border rounded-md' src={image ? URL.createObjectURL(image):''} alt="" />
                    </div>

                    
                    <div className='flex flex-col'>
                       <p className='mb-2 font-semibold text-gray-600'>Background Removed</p>
                       <div className='relative h-full overflow-hidden border border-gray-300 rounded-md bg-layer'>
                            <img src={resultImage ? resultImage : ''} alt="" />
                            {
                                !resultImage && image && <div className='absolute transform translate-x-1/2 translate-y-1/2 right-1/2 bottom-1/2'>
                                <div className='w-12 h-12 border-4 rounded-full border-violet-600 border-t-transparent animate-spin'></div>
                             </div>
                            }
                            
                            
                        </div>                      
                    </div>
                </div>
            </div>
            { resultImage && <div className='flex flex-wrap items-center justify-center gap-4 mt-6 sm:justify-end'>
                <Link to = '/'><button className='px-8 py-2.5 text-violet-600 text-sm border border-violet-600 rounded-full hover:scale-105 transition-all duration-700'>Try another image</button></Link>
                <a href={resultImage} download className='px-8 py-2.5 text-white bg-gradient-to-r from-violet-600 to-fuchsia-500 border rounded-full hover:scale-105 transition-all duration-700'>Download image</a>
            </div>}
        </div>
    )
}

export default Result;