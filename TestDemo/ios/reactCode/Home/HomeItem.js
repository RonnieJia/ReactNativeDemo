'use strict'
import React, { Component, PropTypes } from 'react';
import { requireNativeComponent } from 'react-native';

// requireNativeComponent 自动把这个组件提供给 "RCTScrollView"
var RCTHomeItem = requireNativeComponent('HomeItem', HomeItem);

export default class HomeItem extends Component {

  render() {
    return <RCTHomeItem {...this.props} />;
  }

}

HomeItem.propTypes = {
    /**
    * 属性类型，其实不写也可以，js会自动转换类型
    */
    // autoScrollTimeInterval: PropTypes.number,
    // imageURLStringsGroup: PropTypes.array,
    // autoScroll: PropTypes.bool,

    onClickBtn: PropTypes.func
};


module.exports = HomeItem;
