From: Nikita Yushchenko <nyushchenko@dev.rtsoft.ru>
Subject: [v3.10-rt / v3.12-rt] scheduling while atomic in cgroup code
Date: Sat, 21 Jun 2014 07:55:04 +0400
Message-ID: <53A50218.6020506@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: 'Alexey Lugovskoy' <lugovskoy@dev.rtsoft.ru>,
	Konstantin Kholopov <kkholopov@dev.rtsoft.ru>,
	linux-kernel@vger.kernel.org
To: linux-rt-users@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi.

Call Trace:
[e22d5a90] [c0007ea8] show_stack+0x4c/0x168 (unreliable)
[e22d5ad0] [c0618c04] __schedule_bug+0x94/0xb0
[e22d5ae0] [c060b9ec] __schedule+0x530/0x550
[e22d5bf0] [c060bacc] schedule+0x30/0xbc
[e22d5c00] [c060ca24] rt_spin_lock_slowlock+0x180/0x27c
[e22d5c70] [c00b39dc] res_counter_uncharge_until+0x40/0xc4
[e22d5ca0] [c013ca88] drain_stock.isra.20+0x54/0x98
[e22d5cc0] [c01402ac] __mem_cgroup_try_charge+0x2e8/0xbac
[e22d5d70] [c01410d4] mem_cgroup_charge_common+0x3c/0x70
[e22d5d90] [c0117284] __do_fault+0x38c/0x510
[e22d5df0] [c011a5f4] handle_pte_fault+0x98/0x858
[e22d5e50] [c060ed08] do_page_fault+0x42c/0x6fc
[e22d5f40] [c000f5b4] handle_page_fault+0xc/0x80

What happens:

- refill_stock() calls get_cpu_var() and thus disables preemption until
matching put_cpu_var() is called,

- then it calls drain_stock() -> res_counter_uncharge() ->
res_counter_uncharge_until()

- and here we have spin_lock(), which under RT can sleep. Thus we have 
sleeping with preemption disabled.


Any ideas how to fix?
