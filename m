From: "Girish kathalagiri" <girish.sk@gmail.com>
Subject: BUG: scheduling while atomic: stress
Date: Thu, 26 Jul 2007 13:35:59 +0000
Message-ID: <34ac6d890707260635m1d1165d1m5e01b7faa925e86c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:41950 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbXGZNgA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 26 Jul 2007 09:36:00 -0400
Received: by an-out-0708.google.com with SMTP id d31so103020and
        for <linux-rt-users@vger.kernel.org>; Thu, 26 Jul 2007 06:35:59 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,
I am running linux-2.6.22.1-rt8 on mpc5200 and on running stress

./stress --cpu 8 --io 4 --vm 2 --vm-bytes 2M --timeout 300s

I get the following stack.But this does not happen with non rt kernel.

    LR = 0xff51fcc
BUG: scheduling while atomic: stress/0x00000002/739, CPU#0
Call Trace:
[c04fbb80] [c0008650] show_stack+0x50/0x190 (unreliable)
[c04fbbb0] [c0016fc0] __schedule_bug+0x38/0x48
[c04fbbc0] [c01d4f7c] __schedule+0x3dc/0x450
[c04fbbf0] [c01d56c8] schedule+0x54/0xf0
[c04fbc00] [c01d6390] rt_spin_lock_slowlock+0x100/0x224
[c04fbc60] [c0052198] get_zone_pcp+0x30/0x58
[c04fbc80] [c0053078] free_hot_cold_page+0x114/0x1fc
[c04fbcb0] [c0056424] put_page+0x50/0x15c
[c04fbcd0] [c0069854] free_page_and_swap_cache+0x44/0x80
[c04fbce0] [c005d760] unmap_vmas+0x2e0/0x788
[c04fbd70] [c006292c] exit_mmap+0x74/0x108
[c04fbda0] [c001adc0] mmput+0x54/0xf0
[c04fbdc0] [c001ecfc] exit_mm+0xc0/0x124
[c04fbde0] [c001ffd0] do_exit+0x164/0x8bc
[c04fbe20] [c0020760] do_group_exit+0x38/0x90
[c04fbe40] [c002ba48] get_signal_to_deliver+0x2ac/0x3c0
[c04fbe70] [c000739c] do_signal+0x50/0x60c
[c04fbf40] [c000fec0] do_user_signal+0x74/0xc4
--- Exception: c00 at 0xfeab1dc
    LR = 0xff51fcc

Thanks in advance

--
Regards,
Girish S Kathalagiri
           *****
Someone asked me "Who will let you do it ?"
I said "Thats not the point.The point is, who will stop me ?"
           *****
