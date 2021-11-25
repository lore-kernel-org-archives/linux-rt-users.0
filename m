Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82910C4332F
	for <linux-rt-users@archiver.kernel.org>; Thu, 25 Nov 2021 11:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhKYLQj (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 25 Nov 2021 06:16:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbhKYLOh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 25 Nov 2021 06:14:37 -0500
Date:   Thu, 25 Nov 2021 12:11:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637838685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RU0ccQbFL3dLVJh8ruhH7bnhF5kQZojevRENpOcShJk=;
        b=SRbdi+cWEoFp1xa0rFkUF6wq95cDeCR70X8Ly0PVZXsRMv/fEbtRDO9n/XBCXQDehNSw+z
        kmRTaDwf/3IWi4hJkoTM5mjKh9sF0Ta3s9mQN50Ic7j0NuBRttRfyWOu2l8IfjognVXEgE
        7efhr9QbDiPpvtlBRTxc/7n4lCpggTsYRIrYGHfjlBrK5/4ZkMwgyVp4zOZHQU1rek0DXZ
        6cp0Vw3CimS3d5Zh2SbSwAsZh2bgPU8KqdsRMEcHgtl8jK4VNvOnptA95wUNDoSjsuwRUy
        vzllGbJohw9myjVFFyQ+X2K70XiEIAODmSMTtIdRc7FXNKt3hbADYOlFBe2BzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637838685;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RU0ccQbFL3dLVJh8ruhH7bnhF5kQZojevRENpOcShJk=;
        b=iyeyyGf2JiJfuxK7QT10esT21raNhOMhHFVAnhXw1UHaFsiaVdtwPP3GIDsHjOzz9/re0C
        PKwrE5Og/ha9M+DA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Luis Goncalves <lgoncalv@redhat.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        stable-rt@vger.kernel.org, Nitesh Narayan Lal <nilal@redhat.com>,
        Pei Zhang <pezhang@redhat.com>
Subject: Re: [RFC RT v5.10] [rt] repair usage of dev_base_lock in
 netstat_show()
Message-ID: <20211125111124.sv7spgy2lm7qtxxc@linutronix.de>
References: <YVuviZ3F7MbPvleo@uudg.org>
 <20211011135609.22y7hkycbqm52w6d@linutronix.de>
 <20211011163601.m6j3ibb7ydeevpiz@linutronix.de>
 <CAD8J--8CjZym2afG3iSdztz51nOt9gmy747KPDxdmr1_WzwxcA@mail.gmail.com>
 <CAD8J---uJXqKeYR_3_8O5WPr9pVH8HX1DmGfE+7MdHDmaK4-Mw@mail.gmail.com>
 <CAD8J---a6X1u7SvKs5mR=EzxJ1uUxYZ0OGqM3PPq_LowBgY-Gw@mail.gmail.com>
 <20211125100109.qxc6k4a46s6ndv4e@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211125100109.qxc6k4a46s6ndv4e@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-25 11:01:10 [+0100], To Luis Goncalves wrote:
> 
> It makes sense to only change that one invocation. Let me form a patch.

So I made dis:

| From aaef7596167b3b38a81567af81aaa2f9559c91df Mon Sep 17 00:00:00 2001
| From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
| Date: Thu, 25 Nov 2021 11:05:17 +0100
| Subject: [PATCH] net-sysfs: Acquire dev_base_lock disabled BH in
|  netstat_show()
| 
| The writer acquires dev_base_lock with disabled bottom halves.
| The reader can acquire dev_base_lock without disabling bottom halves
| because there is no writer in softirq context. Also readers can acquire
| the lock in task and softirq context and multiple readers are allowed.
| 
| On PREEMPT_RT the softirqs are preemptible and local_bh_disable() acts
| as a lock to ensure that resources, that are protected by disabling
| bottom halves, remain protected.
| This leads to a circular locking dependency if the lock acquired with
| disabled bottom halves (as in write_lock_bh()) and somewhere else with
| enabled bottom halves (as by read_lock() in netstat_show()) followed by
| disabling bottom halves (cxgb_get_stats() -> t4_wr_mbox_meat_timeout()
| -> spin_lock_bh()). This is the reverse locking order.
| 
| In order to avoid the reverse locking order, acquire the dev_base_lock
| with disabled bottom halves.
| 
| Reported-by: Pei Zhang <pezhang@redhat.com>
| Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
| Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

and then I started locking for in-softirq reader or writer. I can't find
any. Therefore I made this for testing:

diff --git a/net/core/dev.c b/net/core/dev.c
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -371,12 +371,12 @@ static void list_netdevice(struct net_device *dev)
 
 	ASSERT_RTNL();
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_add_tail_rcu(&dev->dev_list, &net->dev_base_head);
 	netdev_name_node_add(net, dev->name_node);
 	hlist_add_head_rcu(&dev->index_hlist,
 			   dev_index_hash(net, dev->ifindex));
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(net);
 }
@@ -389,11 +389,11 @@ static void unlist_netdevice(struct net_device *dev)
 	ASSERT_RTNL();
 
 	/* Unlink dev from the device chain */
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	list_del_rcu(&dev->dev_list);
 	netdev_name_node_del(dev->name_node);
 	hlist_del_rcu(&dev->index_hlist);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	dev_base_seq_inc(dev_net(dev));
 }
@@ -1272,15 +1272,15 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	netdev_adjacent_rename_links(dev, oldname);
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	netdev_name_node_del(dev->name_node);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	synchronize_rcu();
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	netdev_name_node_add(net, dev->name_node);
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 
 	ret = call_netdevice_notifiers(NETDEV_CHANGENAME, dev);
 	ret = notifier_to_errno(ret);
diff --git a/net/core/link_watch.c b/net/core/link_watch.c
--- a/net/core/link_watch.c
+++ b/net/core/link_watch.c
@@ -55,7 +55,7 @@ static void rfc2863_policy(struct net_device *dev)
 	if (operstate == dev->operstate)
 		return;
 
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 
 	switch(dev->link_mode) {
 	case IF_LINK_MODE_TESTING:
@@ -74,7 +74,7 @@ static void rfc2863_policy(struct net_device *dev)
 
 	dev->operstate = operstate;
 
-	write_unlock_bh(&dev_base_lock);
+	write_unlock(&dev_base_lock);
 }
 
 
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -842,9 +842,9 @@ static void set_operstate(struct net_device *dev, unsigned char transition)
 	}
 
 	if (dev->operstate != operstate) {
-		write_lock_bh(&dev_base_lock);
+		write_lock(&dev_base_lock);
 		dev->operstate = operstate;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	}
 }
@@ -2779,11 +2779,11 @@ static int do_setlink(const struct sk_buff *skb,
 	if (tb[IFLA_LINKMODE]) {
 		unsigned char value = nla_get_u8(tb[IFLA_LINKMODE]);
 
-		write_lock_bh(&dev_base_lock);
+		write_lock(&dev_base_lock);
 		if (dev->link_mode ^ value)
 			status |= DO_SETLINK_NOTIFY;
 		dev->link_mode = value;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 	}
 
 	if (tb[IFLA_VFINFO_LIST]) {
diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -30,13 +30,13 @@ static bool is_slave_up(struct net_device *dev)
 
 static void __hsr_set_operstate(struct net_device *dev, int transition)
 {
-	write_lock_bh(&dev_base_lock);
+	write_lock(&dev_base_lock);
 	if (dev->operstate != transition) {
 		dev->operstate = transition;
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 		netdev_state_change(dev);
 	} else {
-		write_unlock_bh(&dev_base_lock);
+		write_unlock(&dev_base_lock);
 	}
 }
 

If this does not create any warnings (with or without RT) then I would
suggest to remove that _bh suffix since there is no need for it. This
should also fix the RT warning you see now.
Agreed?
 
Sebastian
