import { assets } from "../assets/assets";

const Footer = () => {
    return (
        <div className="flex items-center justify-between gap-4 px-4 py-3 lg:px-44">
            <img width={40} src={assets.ClearCutLogo} alt="" />
            <p className="flex-1 pl-4 text-sm text-gray-500 border-gray-400 border-1 max-sm:hidden ">Copyright @ClearCut.dev | All right reserved.</p>
            <div className="flex gap-1">
                <img width={40} src={assets.facebook_icon} alt="" />
                <img width={40} src={assets.twitter_icon} alt="" />
                <img width={40} src={assets.google_plus_icon} alt="" />
            </div>
        </div>
    )
}

export default Footer;