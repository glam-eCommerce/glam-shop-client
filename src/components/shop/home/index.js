import React, { Fragment, createContext, useReducer, useEffect, useState } from "react";
import Layout from "../layout";
import Slider from "./Slider";
import ProductCategory from "./ProductCategory";
import { homeState, homeReducer } from "./HomeContext";
import SingleProduct from "./SingleProduct";
import Promo from "./Promo";
import axios from "axios";

const apiURL = process.env.REACT_APP_API_URL;

export const HomeContext = createContext();

const HomeComponent = () => {
  
  const [promo, setPromo] = useState("");
  
  const fetchData = async () => {
    try {
      const response = await axios.get(`${apiURL}/promo`);
      setPromo(response.text());
    } catch (error) {
      console.log('Error fetching promo', error);
    }
  }
  
  useEffect(() => {
    fetchData();
  }, []);

  return (
    <Fragment>
      <Slider />
      {/* Category, Search & Filter Section */}
      <section className="m-4 md:mx-8 md:my-6">
        {/* Promo */}
        <Promo promo={promo}/>
        <ProductCategory />
      </section>
      {/* Product Section */}
      <section className="m-4 md:mx-8 md:my-6 grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4">
        <SingleProduct />
      </section>
    </Fragment>
  );
};

const Home = (props) => {
  const [data, dispatch] = useReducer(homeReducer, homeState);
  return (
    <Fragment>
      <HomeContext.Provider value={{ data, dispatch }}>
        <Layout children={<HomeComponent />} />
      </HomeContext.Provider>
    </Fragment>
  );
};

export default Home;
