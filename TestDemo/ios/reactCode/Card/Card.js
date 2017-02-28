'use strict'

import React, { Component } from 'react';

import {
  AppRegistry,
  View,
  Image,
  ListView,
  NativeModules,
  TouchableHighlight,
  StyleSheet,
  RecyclerViewBackedScrollView,
  Text,
} from 'react-native';

var Dimensions = require('Dimensions');
var ScreenWidth = Dimensions.get('window').width;
var JSUseOCBridgeModule = NativeModules.JSUseOCBridgeModule;

var Card = React.createClass({
  componentWillMount(){

  },

  getInitialState(){
    var ds = new ListView.DataSource({rowHasChanged: (r1, r2) => r1 !== r2});
    return{
      dataSource: ds.cloneWithRows(this._genRows({})),
    };
  },

  _genRows: function(pressData:{[key:number]:boolean}): Array<String> {
    var dataArr = [];
    dataArr.push('http://c.hiphotos.baidu.com/image/pic/item/9a504fc2d5628535b701d6cd94ef76c6a6ef637c.jpg');
    dataArr.push('http://d.hiphotos.baidu.com/image/pic/item/72f082025aafa40ff096c931af64034f79f0198d.jpg');
    dataArr.push('http://c.hiphotos.baidu.com/image/pic/item/ac345982b2b7d0a2367a0371cfef76094a369aae.jpg');
    dataArr.push('http://e.hiphotos.baidu.com/image/pic/item/730e0cf3d7ca7bcb0634c0c3ba096b63f724a88a.jpg');
    dataArr.push('http://e.hiphotos.baidu.com/image/pic/item/562c11dfa9ec8a139796500cf303918fa1ecc04a.jpg');
    dataArr.push('http://g.hiphotos.baidu.com/image/pic/item/a71ea8d3fd1f4134e9330292211f95cad0c85ed1.jpg');
    dataArr.push('http://b.hiphotos.baidu.com/image/pic/item/c2fdfc039245d6884dddb648a0c27d1ed31b247a.jpg');
    dataArr.push('http://g.hiphotos.baidu.com/image/pic/item/a5c27d1ed21b0ef485629fb2d9c451da80cb3e57.jpg');
    dataArr.push('http://a.hiphotos.baidu.com/image/pic/item/c2fdfc039245d6884ce5b548a0c27d1ed31b2472.jpg');
    dataArr.push('http://e.hiphotos.baidu.com/image/pic/item/6a63f6246b600c3393a1da241e4c510fd8f9a105.jpg');
    dataArr.push('http://a.hiphotos.baidu.com/image/pic/item/622762d0f703918f58533a26553d269758eec458.jpg');

    return dataArr;
  },
  render(){
    return(
      <ListView
        dataSource={this.state.dataSource}
        renderRow={this._renderRow}
        renderScrollComponent={props => <RecyclerViewBackedScrollView {...props} />}
        renderSeparator={this._renderSeperator}
      />
    );
  },

  _renderRow: function(rowData: string, sectionID: number, rowID: number, highlightRow: (sectionID: number, rowID: number) => void) {

      return (
        <TouchableHighlight onPress={() => {
            // this._pressRow(rowID);
            // highlightRow(sectionID, rowID);
          }}>
          <View>
            <View style={styles.row}>
              <Image style={styles.thumb} source={{uri:rowData}} />
            </View>
          </View>
        </TouchableHighlight>
      );
    },
  _renderSeperator: function(sectionID: number, rowID: number, adjacentRowHighlighted: bool) {
    return (
      <View
        key={`${sectionID}-${rowID}`}
        style={{
          height: adjacentRowHighlighted ? 4 : 1,
          backgroundColor: adjacentRowHighlighted ? '#3B5998' : '#CCCCCC',
        }}
        />
  );
}

});

var styles = StyleSheet.create({
  row: {
    flexDirection: 'row',
    justifyContent: 'center',
    padding: 10,
    backgroundColor: '#F6F6F6',
  },
  thumb: {
    width: ScreenWidth-20,
    height: (ScreenWidth-20)*1.6,
  },
  text: {
    flex: 1,
  },
});

AppRegistry.registerComponent('Card', () => Card);
