'use strict'

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  ScrollView,
  Image,
  TouchableHighlight,
  AlertIOS,
  Navigator,
  NativeModules,
  Button
} from 'react-native';

var Dimensions = require('Dimensions');
var ScreenWidth = Dimensions.get('window').width;
var JSUseOCBridgeModule = NativeModules.JSUseOCBridgeModule;
var HomeItem = require('./HomeItem');
var HomeBanner = require('./HomeBanner');

const bannerImgs = ['http://f.hiphotos.baidu.com/image/h%3D200/sign=c253602d791ed21b66c929e59d6cddae/b151f8198618367a9f738e022a738bd4b21ce573.jpg',
                    'http://a.hiphotos.baidu.com/image/pic/item/b999a9014c086e068d8c874b00087bf40ad1cb8e.jpg'
                  ];

var Home = React.createClass({
  getInitialState() {
    return{
      userIcon: this.props.icon,
    };
  },

  _handleApp(btnTag) {
    if (btnTag === 1) {
      AlertIOS.alert('ht' + this.props.navigator);
    } else {

    }
  },

  render() {
    var userImg = this.props.icon;

    return(
      <View style={styles.container}>
        <ScrollView>
          <HomeBanner style={styles.banner}
            imageURLStringsGroup={bannerImgs}
            onClickBanner = {(e) => {
              console.log('text' + e.nativeEvent.value);
            }}
           />
          <View style={{width:ScreenWidth, height:70, backgroundColor:'white', flex:1, flexDirection:'row'}}>
              <HomeItem style={styles.button}
                title={'中国银行'}
                desc={'中国银行掌上APP'}
                icon={'drewr'}
                btnTag={1}
                onClickBtn={(e) => this._handleApp(e.nativeEvent.value)}
              />
              <HomeItem style={styles.button}
                title={'中银易商'}
                desc={'中国银行掌上银行'}
                icon={'yishang'}
                btnTag={2}
                onClickBtn={(e) => this._handleApp(e.nativeEvent.value)}

              />
          </View>
          <View style={{width:ScreenWidth, height:1, backgroundColor:'#C8C8C8'}}></View>
          <View style={styles.bottom}>
            <TouchableHighlight underlayColor='white' onPress={() => {
              JSUseOCBridgeModule.changeUserIcon((error, imgUrl) => {
                this.setState({
                  userIcon:imgUrl
                });
              });
            }} >
              <Image style={styles.userIcon} source={{uri:this.state.userIcon}} ></Image>
            </TouchableHighlight>
            <Text style={{marginTop:10, marginBottom:15, fontSize:22, fontWeight:'bold'}}>{this.props.userName}</Text>
            <View style={{width:ScreenWidth-20, height:100}}>
              <Text style={styles.text} >身份证号：{this.props.idno}</Text>
              <Text style={styles.text} >账号类型：{this.props.userType}</Text>
              <Text style={styles.text} >所属单位：{this.props.userIssue}</Text>
              <Text style={styles.text} >账户余额：{this.props.money}元</Text>
            </View>
          </View>

        </ScrollView>
      </View>
    );
  },
});

const styles = StyleSheet.create({
  container: {
    flex:1,
    backgroundColor:'white',
    height:Dimensions.get('window').height-64-49,
  },
  banner: {
    width: ScreenWidth,
    height:ScreenWidth / 375.0 * 210,
    backgroundColor:'white',
  },
  button:{
    width:(ScreenWidth-30)/2.0,
    height:50,
    backgroundColor:'white',
    marginLeft:10,
    marginTop: 10,
  },
  bottom: {
    flex:1,
    flexDirection:'column',
    alignItems:'center',
    width:ScreenWidth-20,
    marginLeft:10,
    marginTop:10,
    marginBottom:30,
    height:290,
    backgroundColor:'white',
    borderColor:'black',
    borderWidth:1,
    borderRadius:5,
  },
  userIcon: {
    marginTop:18,
    width:80,
    height:80,
    backgroundColor:'red',
    borderRadius:40,
    borderColor:'#DBDBDB',
    borderWidth:2.0,
    overflow:'hidden'
  },
  text:{
    fontSize:14,
    color:'#414141',
    marginBottom:10,
    marginLeft:90 * ScreenWidth / 375.0,
    width:ScreenWidth- 90 * ScreenWidth / 375.0 - 30,
  },
});
AppRegistry.registerComponent('Home', () => Home);
// module.exports = Home;
