From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Making rcu_normal=1 in RT
Date: Wed, 12 Oct 2016 11:12:51 -0400
Message-ID: <20161012111251.74d1d52e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bigeasy@linutronix.de, joshc@ni.com, mst@redhat.com,
        paulmck@linux.vnet.ibm.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:26303 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933584AbcJLPs3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Oct 2016 11:48:29 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

We have the following patch applied to the RT tree:

  commit a9d3cc781a3306bfa332fa7cb6134b70696058d5
  Author: Josh Cartwright <joshc@ni.com>
  Date:   Tue Oct 27 07:31:53 2015 -0500
  
      net: Make synchronize_rcu_expedited() conditional on !RT_FULL

However, as noted by Michael, making rcu_normal=1 default in the
RT kernel should have the same effect (ie.  not calling
synchronize_sched_expedited()).

So, honest question, is there a reason not to:

 1. Drop the patch above
 2. Make rcu_normal=1 default?
