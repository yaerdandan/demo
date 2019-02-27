<?php
namespace app\admins\controller;
use think\Controller;
use Util\data\Sysdb;

class Account extends Controller {
	public function login() {
		return view();
	}
	//管理员登录
	public function dologin() {
		$username = input('post.username');
		$pwd = input('post.password');
		$verifycode = input('post.verifycode');
		if ($username == '') {
			echo "<script>alert('请输入用户名');location.href='/tp5/public/admins/account/login'</script>";
		}
		if ($pwd == '') {
			echo "<script>alert('请输入密码');location.href='/tp5/public/admins/account/login'</script>";
		}
		if ($verifycode == '') {
			echo "<script>alert('请输入验证码');location.href='/tp5/public/admins/account/login'</script>";
		}
		//验证验证码
		if (!captcha_check($verifycode)) {
			echo "<script>alert('验证码错误');location.href='/tp5/public/admins/account/login'</script>";
		}
		//验证用户
		$this->db = new Sysdb;
		$admin = $this->db->table('admins')->field()->where(array('username' => $username))->item();
		if (!$admin) {
			echo "<script>alert('用户名错误');location.href='/tp5/public/admins/account/login'</script>";
		}

		if ($pwd != $admin['password']) {
			echo "<script>alert('密码错误');location.href='/tp5/public/admins/account/login'</script>";
		}
		if ($admin['status'] == 1) {
			echo "<script>alert('用户被禁用');location.href='/tp5/public/admins/account/login'</script>";
		}
		//设置session
		session('admin', $admin);
		echo "<script>location.href='/tp5/public/admins/Home/index'</script>";
	}
	public function logout(){
		session('admin',null);
		exit(json_encode(array('code'=>0,'msg'=>'退出成功')));
	}
}