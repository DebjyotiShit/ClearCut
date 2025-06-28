import { testimonialsData } from "../assets/assets";

const Testimonials = () =>{
    return(
        <div>


            <h1 className="text-2xl font-semibold text-center text-gray-600 md:text-3xl lg:text-4xl bg-clip-text ">Customer Testimonials</h1>
            <div className="grid max-w-4xl grid-cols-1 gap-10 px-4 py-8 mx-auto md:grid-cols-2">
                {testimonialsData.map((item, index) => (
                    <div className="max-w-lg p-6 m-auto transition-all duration-700 bg-white rounded-xl drop-shadow-md hover:scale-105" key={index}>
                        <p className="text-4xl text-gray-500">”</p>
                        <p className="text-sm text-gray-500">{item.text}</p>
                        <div className="flex items-center gap-3 mt-5">
                            <img className="rounded-full w-9" src={item.image} alt="" />
                            <div>
                                <p>{item.author}</p>
                                <p className="text-sm text-gray-600">{item.jobTitle}</p>
                            </div>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    )
}

export default Testimonials;