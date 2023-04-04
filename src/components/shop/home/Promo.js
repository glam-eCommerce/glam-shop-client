import React from "react";

const Promo = ({promo}) => {
  
  return <div className="mx-0 relative text-center text-2xl font-bold w-100 p-5"
    style={{height: "30px", 
      backgroundColor: "#b7791f",
      color: "#fff",
    }}>{promo}</div>;
};

export default Promo;
