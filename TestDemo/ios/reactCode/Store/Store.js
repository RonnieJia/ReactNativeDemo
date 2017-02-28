'use strict'

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  View,
  Text,
  ScrollView,
  TouchableHighlight,
  AlertIOS,
  NativeModules,
  Image,
} from 'react-native';

var Dimensions = require('Dimensions');
var ScreenWidth = Dimensions.get('window').width;
var JSUseOCBridgeModule = NativeModules.JSUseOCBridgeModule;

var Store = React.createClass({
  getInitialState() {
    return{
      userIcon: this.props.icon,
    };
  },

  render() {

    return (
      <View style={styles.container} >
        <ScrollView>
          <View style={styles.topContainer}>
            <TouchableHighlight underlayColor='white' onPress={() => {
              JSUseOCBridgeModule.changeUserIcon((error, imgUrl) => {
                thsi.setState({
                  userIcon:this.props.icon,
                });
              });
            }} >
              <Image style={styles.userIcon}
                source={{uri:this.state.userIcon}}
              />
            </TouchableHighlight>

            <Text style={{marginTop:15,
              textAlign:'center',
              fontWeight:'bold',
              width:ScreenWidth-20,
              fontSize:18,}}
            >{this.props.userName}</Text>

            <Text style = {styles.text}>{this.props.idno}</Text>

          </View>

          <View style={{backgroundColor:'#E5E5E5', height:1}}></View>
        </ScrollView>
      </View>
    );
  }

});

const styles = StyleSheet.create({
  container: {
    flex:1,
    backgroundColor:'#F8F8F8',
  },
  topContainer:{
    flex:1,
    flexDirection:'column',
    alignItems:'center',
    backgroundColor:'white',
    width:ScreenWidth,
    height:160,
  },
  userIcon: {
    marginTop:15,
    width:70,
    height:70,
    backgroundColor:'red',
    borderRadius:35,
    borderColor:'#DBDBDB',
    borderWidth:2.0,
    overflow:'hidden'
  },
  text:{
    fontSize:14,
    color:'blue',
    marginTop:10,
    marginLeft:90 * ScreenWidth / 375.0,
    width:ScreenWidth- 90 * ScreenWidth / 375.0 - 30,
  },
});

AppRegistry.registerComponent('Store', () => Store);
