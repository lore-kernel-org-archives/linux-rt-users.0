Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A56716F854
	for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967005; cv=none; b=eXWJypKw23G8WVEVelSPy+bDwnluLbY9adTfWOzRlSTKaHKUKZrs13GrWAacAoRLkZaY8PymCV2+0mV8LBioFLsWGZMVCFMgHYDOr0WQ9mbLvsvmBIcqKCj83OizmDgKkFhRdhygPdLe9ecOVl9oGbgr4ja5XKHHAbbyXOs8Ue8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967005; c=relaxed/simple;
	bh=PPWduEZpjfNs3/2+j1zwWl1tubmzUgKRaHvP5A8k2mc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hi0xvNSx80CSvteKOcf59t4Vsl3IRJ1oIyvUKd5PmLgtcK8SGF6rOPyv4LgHOJLbd5wRyL92X42IyJHw3c61gT+HRYu9UAs4y9c7ehGJWStqwPT3N80xltseRwND/S1N2OrvvMNVPj1wx2xCBziBdOCkOE0dsbkplivdChOEggU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=kJY2JJdP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="kJY2JJdP"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-70a365a4532so1673048a12.1
        for <linux-rt-users@vger.kernel.org>; Fri, 21 Jun 2024 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1718966999; x=1719571799; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YHw26fYNtbVg90pb/0vXhYC2RIqSga4ERHI4UzA2SBA=;
        b=kJY2JJdPjz4oHcnsgLOQFj8XCATwRPlwzd8GWbLb+4PXs4mXAylatNblrRkIolxPeh
         q7ssvfr6/F81JFn7LW5K2z87Ydvc984ziPr7x2f2UYAQnSu2s65SLoOcYE+3hQcqYq41
         XLSOPJ8S+MIjSXBylKQHkw0sLXXyn0OZCLgyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718966999; x=1719571799;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YHw26fYNtbVg90pb/0vXhYC2RIqSga4ERHI4UzA2SBA=;
        b=nmi8e7mDLBJTjFrmG6/ZsvgAg1zUJLQx8r97XY4l09bMA5nwSFKVIYT7T7LzxzSiCS
         4yNf/xL523TD76ebsnFILgphI/ITkT0Da9EnvSeriGjhMAhGsehBRevCDFpKejHZ9h3w
         vXcJEdJClMmpjpMJFULtrGFA/p18Ga194KoWsmlWSc6FhotKdeX71LWO6qhaJdnvteQa
         /E+PH7bQW6hAhAhrw6bYBgyBNfT9lLFCay/hMgcA9P4dZSjJFkB+Z2y3zv9WLC6qvmXB
         qMBl1IYQmKw2Cm6srNgmEoeP3eNF+aftQ2MzUKoAkMzIodWecGbYbIbbOxrM4AS0LWE1
         sS+w==
X-Gm-Message-State: AOJu0YyFMH3NCTRORNd3++GtNo/knmAvdDssGiCkSVBWan2seCI+gYq6
	tdBnUrxQ+C+IJV3C38YZ2USRVW9+jZRmy8J5NCUNDFclwtQfxnpYKciGsKtG1MRI0GBcINXmePE
	M
X-Google-Smtp-Source: AGHT+IEyVFpOJx0pO9aGMKZ3sNs0OOvNIh6JEqB3B4LPg/mwPqNrsiNNsiGyJ9ZPS/E84z4PGw2hfg==
X-Received: by 2002:a17:90a:ec06:b0:2c2:cee8:bd6e with SMTP id 98e67ed59e1d1-2c7b5dee324mr7263094a91.49.1718966999389;
        Fri, 21 Jun 2024 03:49:59 -0700 (PDT)
Received: from sam-Latitude-3400.mvista.com ([2a0c:5a81:a102:2900:e1da:404e:9c0d:e1b8])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716ba79ff2esm881743a12.65.2024.06.21.03.49.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jun 2024 03:49:58 -0700 (PDT)
From: Sam Kappen <skappen@mvista.com>
To: linux-rt-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	tom.zanussi@linux.intel.com,
	zanussi@kernel.org,
	sam.gsk@gmail.com,
	Sam Kappen <skappen@mvista.com>
Subject: [PATCH RT v4.19] tcp: md5: Add a serialization in tcp MD5 hash functions.
Date: Fri, 21 Jun 2024 12:49:32 +0200
Message-Id: <1718966972-17507-1-git-send-email-skappen@mvista.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>

A crash was observed when stress testing tcp MD5 feature in 4.19 RT kernel.
Issue is reproducible on the 4.x based RT kernels.
It is due to a race issue in tcp md5 hash functions.
They are called from the softirqs that are processed in parallel
on the same cpu.In non RT it is prevented by disabling BH but
it would not work on RT. Fix this issue by adding a serialization.
There have been similar issues in the RT 4.x kernel,
ad01e514374 (net: xfrm: fix compress vs decompress serialization)
is one of that kind.

This issue is not applicable on later 5.x RT kernel versions onwards.
The commit "6f6ba7715a9" (softirq: rework) in v5.0.19-rt11
and later its stable commit version 96fac673174
(softirq: Add preemptible softirq) does a rework on softirq
so that if we disable the  BH two softirqs cannot be
processed in parallel on the same CPU in RT.

[   97.017722] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[   97.017723] PGD 46152a067 P4D 46152a067 PUD 46174d067 PMD 0
[   97.017726] Oops: 0000 [#1] PREEMPT SMP
[   97.017727] CPU: 3 PID: 2329 Comm: tcp_stress_md5 Not tainted 4.19.315-rt135-yocto-standard #1
[   97.017727] Hardware name: Supermicro Super Server/X11SSH-F, BIOS 2.0c 10/06/2017
[   97.017731] RIP: 0010:hash_walk_new_entry+0x4/0x50
[   97.017732] Code: 72 cf ff 65 48 8b 14 25 c0 9d 01 00 83 82 dc 0a 00 00 01 48 8b 7c 24 08 8b 44 24 04 8b 4f 18 eb ac 0f 1f 44 00 00 48 8b 77 20 <8b> 46 08 89 47 08 48 8b 0e 89 c2 c1 ea 0c 25 ff 0f 00 00 48 c1 e2
[   97.017732] RSP: 0018:ffffc90002b53730 EFLAGS: 00010246
[   97.017733] RAX: 0000000000000000 RBX: ffff888461fa2710 RCX: 0000000000000ce5
[   97.017734] RDX: 0000000000000008 RSI: 0000000000000000 RDI: ffffc90002b53738
[   97.017734] RBP: ffff8884679a5240 R08: 0000000049466cc1 R09: 0000000000007f15
[   97.017734] R10: 0000000000007f15 R11: 00000000e75d5e25 R12: 0000000000000118
[   97.017735] R13: ffff88845d199118 R14: ffff888461fa26c0 R15: ffff8884679a5240
[   97.017735] FS:  00007f159ffff700(0000) GS:ffff888467980000(0000) knlGS:0000000000000000
[   97.017736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   97.017736] CR2: 0000000000000008 CR3: 00000004615db005 CR4: 00000000003606e0
[   97.017737] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   97.017737] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   97.017737] Call Trace:
[   97.017740]  ? __die+0x62/0xb0
[   97.017742]  ? no_context+0x150/0x3c0
[   97.017744]  ? __switch_to_asm+0x35/0x70
[   97.017745]  ? __switch_to_asm+0x41/0x70
[   97.017746]  ? __switch_to_asm+0x35/0x70
[   97.017747]  ? __do_page_fault+0xe1/0x570
[   97.017748]  ? __schedule+0x272/0x640
[   97.017749]  ? page_fault+0x1e/0x30
[   97.017751]  ? hash_walk_new_entry+0x4/0x50
[   97.017752]  shash_ahash_update+0x20/0x60
[   97.017754]  ? tcp_md5_hash_skb_data+0xe2/0x230
[   97.017755]  tcp_md5_hash_key+0x49/0x70
[   97.017757]  tcp_v4_md5_hash_skb+0xe5/0x130
[   97.017758]  tcp_v4_inbound_md5_hash+0xf5/0x1b0
[   97.017760]  tcp_v4_rcv+0x89a/0xa60
[   97.017761]  ip_local_deliver_finish+0x51/0x1c0
[   97.017762]  ip_local_deliver+0x102/0x110
[   97.017763]  ? ip_rcv_core.isra.17+0x280/0x280
[   97.017764]  ip_rcv+0xdf/0x100
[   97.017765]  ? ip_rcv_finish_core.isra.14+0x350/0x350
[   97.017766]  __netif_receive_skb_one_core+0x53/0x70
[   97.017768]  process_backlog+0x8b/0x170
[   97.017769]  net_rx_action+0x1eb/0x4a0
[   97.017771]  ? dev_hard_start_xmit+0x93/0x2a0
[   97.017773]  do_current_softirqs+0x187/0x370
[   97.017774]  __local_bh_enable+0x46/0x60
[   97.017775]  ip_finish_output2+0x18a/0x3c0
[   97.017776]  ? ip_output+0x66/0x110
[   97.017777]  ip_output+0x66/0x110
[   97.017778]  ? __ip_flush_pending_frames.isra.50+0x80/0x80
[   97.017779]  __ip_queue_xmit+0x166/0x3e0
[   97.017780]  ? tcp_v4_md5_hash_skb+0x119/0x130
[   97.017781]  __tcp_transmit_skb+0x539/0xae0
[   97.017782]  tcp_write_xmit+0x22b/0xf70
[   97.017784]  ? _copy_from_iter_full+0x92/0x260
[   97.017785]  __tcp_push_pending_frames+0x28/0xa0
[   97.017786]  tcp_sendmsg_locked+0x126/0xcc0
[   97.017788]  tcp_sendmsg+0x22/0x40
[   97.017789]  __sock_sendmsg+0x2b/0x40
[   97.017790]  __sys_sendto+0x109/0x140
[   97.017792]  ? do_epoll_wait+0x81/0xc0
[   97.017793]  ? __x64_sys_epoll_pwait+0x107/0x120
[   97.017794]  __x64_sys_sendto+0x1f/0x30
[   97.017796]  do_syscall_64+0x3d/0xf0
[   97.017797]  entry_SYSCALL_64_after_hwframe+0x5c/0xc1
[   97.017798] RIP: 0033:0x3de9210d9a
[   97.017799] Code: 7c 24 08 4c 89 14 24 e8 54 f7 ff ff 45 31 c9 45 31 c0 4c 8b 14 24 89 c3 4c 89 e2 48 89 ee 48 8b 7c 24 08 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 32 89 df 48 89 04 24 e8 83 f7 ff ff 48 8b 04
[   97.017799] RSP: 002b:00007f159fffd840 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
[   97.017800] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000003de9210d9a
[   97.017801] RDX: 00000000000001f4 RSI: 00007f159fffe890 RDI: 000000000000001a
[   97.017801] RBP: 00007f159fffe890 R08: 0000000000000000 R09: 0000000000000000
[   97.017801] R10: 0000000000000000 R11: 0000000000000246 R12: 00000000000001f4
[   97.017802] R13: 00007ffdf2bb780f R14: 0000000000802000 R15: 00007ffdf2bb7810
[   97.017802] Modules linked in:
[   97.017804] CR2: 0000000000000008
[   97.406680] ---[ end trace 0000000000000002 ]---

Signed-off-by: Sam Kappen <skappen@mvista.com>
---
 net/ipv4/tcp_ipv4.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 91c3ed3..31059e9 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -93,6 +93,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 			       __be32 daddr, __be32 saddr, const struct tcphdr *th);
 #endif
 
+static DEFINE_LOCAL_IRQ_LOCK(tcp_md5_lock);
 struct inet_hashinfo tcp_hashinfo;
 EXPORT_SYMBOL(tcp_hashinfo);
 
@@ -1224,6 +1225,7 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 	struct tcp_md5sig_pool *hp;
 	struct ahash_request *req;
 
+	local_lock(tcp_md5_lock);
 	hp = tcp_get_md5sig_pool();
 	if (!hp)
 		goto clear_hash_noput;
@@ -1240,12 +1242,14 @@ static int tcp_v4_md5_hash_hdr(char *md5_hash, const struct tcp_md5sig_key *key,
 		goto clear_hash;
 
 	tcp_put_md5sig_pool();
+	local_unlock(tcp_md5_lock);
 	return 0;
 
 clear_hash:
 	tcp_put_md5sig_pool();
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
+	local_unlock(tcp_md5_lock);
 	return 1;
 }
 
@@ -1267,6 +1271,7 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 		daddr = iph->daddr;
 	}
 
+	local_lock(tcp_md5_lock);
 	hp = tcp_get_md5sig_pool();
 	if (!hp)
 		goto clear_hash_noput;
@@ -1286,12 +1291,14 @@ int tcp_v4_md5_hash_skb(char *md5_hash, const struct tcp_md5sig_key *key,
 		goto clear_hash;
 
 	tcp_put_md5sig_pool();
+	local_unlock(tcp_md5_lock);
 	return 0;
 
 clear_hash:
 	tcp_put_md5sig_pool();
 clear_hash_noput:
 	memset(md5_hash, 0, 16);
+	local_unlock(tcp_md5_lock);
 	return 1;
 }
 EXPORT_SYMBOL(tcp_v4_md5_hash_skb);
-- 
2.7.4

