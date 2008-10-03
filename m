From: Gregory Haskins <ghaskins@novell.com>
Subject: [RT PATCH 0/2] fix for BUG_ON crash in 26.5-rt9
Date: Fri, 03 Oct 2008 08:42:55 -0400
Message-ID: <20081003123745.17387.61782.stgit@dev.haskins.net>
References: <20080925123235.GA27916@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, dvhltc@us.ibm.com, dino@in.ibm.com,
	Gilles.Carry@bull.net
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from 75-130-108-43.dhcp.oxfr.ma.charter.com ([75.130.108.43]:42900
	"EHLO dev.haskins.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751297AbYJCMic (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 3 Oct 2008 08:38:32 -0400
In-Reply-To: <20080925123235.GA27916@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Chirag,

 Please try the following patches applied to 26.5-rt9 and let me know what you
 find.

Hi Steve,
  If these look good to everyone, please consider them for inclusion in -rt10. 

Regards,
-Greg

---

Gregory Haskins (2):
      RT: remove "paranoid" limit in push_rt_task
      RT: Remove comment that is no longer true


 kernel/sched_rt.c |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

