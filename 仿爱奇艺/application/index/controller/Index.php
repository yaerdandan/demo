<?php
namespace app\index\controller;
use think\Controller;
use util\data\Sysdb;
class Index extends controller
{
    public function __construct() {
        parent::__construct();
        $this->db = new Sysdb;
    }

    public function index()
    {
        //轮播图
        $slide_list = $this->db->table('slide')->where(array('type'=>0))->lists();
        //导航标签
        $channel_list  = $this->db->table('video_label')->where(array('flag'=>channel))->lists();
        //今日焦点
        $tody_hot_list = $this->db->table('video')->where(array('channel_id'=>1,'status'=>1))->lists();
        $this->assign('today_hot_list',$tody_hot_list);
        $this->assign('channel_list',$channel_list);
        $this->assign('data',$slide_list);
        return view();  
     }

     public function cate() {
         $date['label_channel'] = (int)input('get.label_channel');
         $date['label_area'] = (int)input('get_label_area');
        $channel_list = $this->db->table('video_label')->where(array('flag'=>'channel'))->lists();
        $charge_list = $this->db->table('video_label')->where(array('flag'=>'charge'))->lists();
        $area_list = $this->db->table('video_label')->where(array('flag'=>'area'))->lists();
        $data = $this->db->table('video')->where(array('status'=>1))->lists();

        $this->assign('data',$data);
        $this->assign('date',$date);
        $this->assign('channel_list',$channel_list);
        $this->assign('charge_list',$charge_list);
        $this->assign('area_list',$area_list);
        return  view();
     }
}
