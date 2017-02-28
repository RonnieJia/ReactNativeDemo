'use strict'

import React, {Component, PropTypes} from 'react';
import { requireNativeComponent } from 'react-native';

var RCTScrollView = requireNativeComponent('HomeBanner', HomeBanner);
export default class HomeBanner extends Component {

  render() {
    return <RCTScrollView {...this.props} />;
  }
}

HomeBanner.propTypes = {
  /**
    * 属性类型，其实不写也可以，js会自动转换类型
    */
    autoScrollTimeInterval: PropTypes.number,
    imageURLStringsGroup: PropTypes.array,
    autoScroll: PropTypes.bool,

    onClickBanner: PropTypes.func
}

module.exports = HomeBanner;
