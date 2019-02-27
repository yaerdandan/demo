<?php
namespace app\admins\controller;
use think\Controller;

class Admin extends BaseAdmin {
	//管理员列表
	public function index() {
		$data['lists'] = $this->db->table('admins')->field()->lists();
		$data['group'] = $this->db->table('admin_groups')->field()->cates('gid');
		$this->assign('data', $data);
		return view();
	}
	public function add() {
		$id = (int) input('get.id');
		//加载管理员
		$data['item'] = $this->db->table('admins')->field()->where(array('id' => $id))->item();
		//加载角色
		$data['group'] = $this->db->table('admin_groups')->field()->cates('gid');
		$this->assign('data', $data);
		return view();
	}

	
	public function save() {
		$id = (int) input('post.id');
		$data['username'] = trim(input('post.username'));
		$data['gid'] = (int) (input('post.gid'));
		$password = trim(input('post.pwd'));
		$data['truename'] = trim(input('post.truename'));
		$data['status'] = (int) (input('post.status'));

		if (!$data['username']) {
			echo "<script>alert('请输入用户名');location.href='/tp5/public/admins/admin/add'</script>";
		}
		if ($id == 0 && !$password) {
			echo "<script>alert('请输入密码');location.href='/tp5/public/admins/admin/add'</script>";
		}
		if (!$data['gid']) {
			echo "<script>alert('角色不能为空');window.parent.location.reload();'</script>";
		}
		if (!$data['truename']) {
			echo "<script>alert('姓名不能为空');location.href='/tp5/public/admins/admin/add'</script>";
		}
		if ($password) {
			//密码处理
			$data['password'] = $password;
		}
		//检查用户名已经存在
		if ($id == 0) {
			$item = $this->db->table('admins')->field()->where(array('username' => $data['username']))->item();
			if ($item) {
				echo "<script>alert('该用户已经存在');location.href='/tp5/public/admins/admin/add'</script>";
			}
			$data['add_time'] = time();
			// 保存用户
			$res = $this->db->table('admins')->insert($data);
		} else {
			$res = $this->db->table('admins')->where(array('id' => $id))->update($data);
			if (!$res) {
				echo "<script>alert('修改失败');window.parent.location.reload();</script>";
			}
			echo "<script>window.parent.location.reload();</script>";
			die;
		}
		if (!$res) {
			echo "<script>alert('保存失败');location.href='/tp5/public/admins/admin/add'</script>";
		} else {
			echo "<script>alert('添加成功');window.parent.location.reload();</script>";
		}
	}
	//删除管理员
	public function delete() {
		$id = (int)input('post.id');
		$res = $this->db->table('admins')->where(array('id' => $id))->delete();
		if ($res) {
			exit(json_encode(array('code'=>0,'msg'=>'删除成功')));
		} else {
			
		}
	}
}