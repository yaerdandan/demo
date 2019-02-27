<?php
namespace app\admins\controller;
use think\Controller;

class Home extends BaseAdmin {
	public function index() {
		$site = $this->db->table('sites')->where(array('names' => 'site'))->item();
		$site && $site['values'] = json_decode($site['values']);
		$this->assign('site', $site);
		$menus = false;
		$role = $this->db->table('admin_groups')->field()->where(array('gid' => $this->_admin['gid']))->item();
		if ($role) {
			$role['rights'] = (isset($role['rights']) && $role['rights']) ? json_decode($role['rights'], true) : [];
		}
		if ($role['rights']) {
			$where = 'mid in(' . implode(',', $role['rights']) . ') and ishidden=0 and status=0';
			$menus = $this->db->table('admin_menus')->field()->where($where)->cates('mid');
			$menus && $menus = $this->gettreeitems($menus);
		}
		$this->assign('role', $role);
		$this->assign('menus', $menus);
		return view();
	}
	private function gettreeitems($items) {
		$tree = array();
		foreach ($items as $item) {
			if (isset($items[$item['pid']])) {
				$items[$item['pid']]['children'][] = &$items[$item['mid']];

			} else {
				$tree[] = &$items[$item['mid']];
			}
		}
		return $tree;
	}

	public function welcome() {
		return view();
	}
}