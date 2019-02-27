<?php
namespace app\admins\controller;
use app\admins\controller\BaseAdmin;

class Video extends BaseAdmin {
//影片列表
	public function index() {
		$data['pageSize'] = 15;
		$data['page'] = max(1,(int)input('get_page'));
		$data['wd'] = trim(input('get.wd'));
		$where = array();
		$data['wd'] && $where = 'title like "%'.$data['wd'].'%"';
		$data['data'] = $this->db->table('video')->order('id desc')->where($where)->pages($data['pagesize']);
		$label_ids = [];
		foreach($data['data']['lists'] as $item) {
			!in_array($item['channel_id'],$label_ids) && $label_ids[] = $item['channel_id'];
			!in_array($item['charge_id'],$label_ids) && $label_ids[] = $item['charge_id'];
			!in_array($item['area_id'],$label_ids) && $label_ids[] = $item['area_id'];
		}
		$label_ids && $data['labels'] = $this->db->table('video_label')->where('id in('.implode(',',$label_ids).')')->cates('id');

		$this->assign('data',$data);
		return view();
	}
	//添加影片
	public function add() {
		$data['channel'] = $this->db->table('video_label')->where(array('flag'=>'channel'))->lists();
		$data['charge'] = $this->db->table('video_label')->where(array('flag'=>'charge'))->lists();
		$data['area'] = $this->db->table('video_label')->where(array('flag'=>'area'))->lists();
		$id = (int)input('get.id');
		$data['item'] =$this->db->table('video')->where(array('id'=>$id))->item();
		$this->assign('data',$data);
		return view();
	}
	//保存
	public function save() {
		$id = (int)input('post.id');
		$data['title'] = trim(input('post.title'));
		$data['channel_id'] = (int)input('post.channel_id');
		$data['charge_id'] = (int)input('post.charge_id');
		$data['area_id'] = (int)input('post.area_id');
		$data['url'] = trim(input('post.url'));
		$data['keywords'] = trim(input('post.keywords'));
		$data['desc'] = trim(input('post.desc'));
		$data['status'] = (int)input('post.status');
		$data['img']=trim(input('post.img'));

		if($data['title'] == '') {
			exit(json_encode(array('code'=>0,'msg'=>'影片名称为空')));
		}
		if($data['url'] == '') {
			exit(json_encode(array('code'=>0,'msg'=>'影片地址为空')));
		}

		if($id) {
			$this->db->table('video')->where(array('id'=>$id))->update($data);
		}else{
			$data['add_time'] = time();
			$this->db->table('video')->insert($data);
		}
		exit(json_encode(array('code'=>0,'msg'=>'保存成功')));

	}
	//上传图片
	public function upload_img(){
		$file = request()->file('file');
		if($file == null) {
			exit(json_encode(array('code'=>1,'msg'=>'没有文件上传')));
		}
		$info = $file->move('uploads');
		$ext = ($info->getExtension());
		if(!in_array($ext,array('jpg','jpeg','gif','png'))){
			exit(json_encode(array('code'=>1,'msg'=>'文件格式不支持')));
		}
		$img = '/tp5/public/uploads/'.$info->getSaveName();
		exit(json_encode(array('code'=>0,'msg'=>$img)));
	}

//删除
	public function delete() {
		$id = (int)input('post.id');
		$this->db->table('video')->where(array('id'=>$id))->delete();
		exit(json_encode(array('code'=>0,'msg'=>'删除成功')));
	}
}
?>