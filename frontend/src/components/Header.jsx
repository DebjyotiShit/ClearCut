import React, { useContext } from 'react';
import { assets } from '../assets/assets';
import { AppContext } from '../context/AppContext';

const Header = () => {
    const {removeBg} = useContext(AppContext);
    return(
        <div className='flex items-center justify-between px-4 mt-10 max-sm:flex-col-reverse gap-y-10 lg:px-44 sm:mt-20'>
            <div>
                <h1 className='text-4xl font-bold leading-tight xl:text-5xl 2xl:text-6xl text-neutral-700'>
                    Remove the <br className='max-md:hidden' /> 
                    <span className='text-transparent bg-gradient-to-r from-violet-600 to-fuchsia-500 bg-clip-text'>
                        background
                    </span> from <br className='max-md:hidden' /> images for free.
                </h1>
                <p className='my-6 text-[15px] text-gray-500'>Our background remover instantly removes the background of your photos in seconds. <br className='max-md:hidden' /> Then you can add any new background or leave it transparent!</p>
                <div>
                    <input onChange={ e => removeBg(e.target.files[0])} type="file" accept='image/*' id="upload1" hidden/>
                    <label className='inline-flex gap-3 px-8 py-3.5 rounded-full cursor-pointer bg-gradient-to-r from-violet-600 to-fuchsia-500 m-auto hover:scale-105 transition-all duration-700 ' htmlFor="upload1">
                        <img width={20} src={assets.upload_btn_icon} alt="" />
                        <p className='text-sm text-white'>Upload your image</p>
                    </label>
                </div>
            </div>
            <div className='w-full max-w-md'>
                <img src={assets.header_img} alt="" />
            </div>
        </div>
    )
}

export default Header;