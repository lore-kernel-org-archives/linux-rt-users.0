From: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
Subject: [PATCH 2.6.21-rc5-rt12] IPV6: Flag bit of ebitmask is not set in
 __inet6_hash.
Date: Thu, 05 Apr 2007 11:45:09 -0700
Message-ID: <461543B5.6080605@ncos.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: dwalker@mvista.com, Mark Huth <mhuth@mvista.com>,
	linux-rt-users@vger.kernel.org
To: mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from homer.mvista.com ([63.81.120.158]:31084 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1767211AbXDESqw (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 5 Apr 2007 14:46:52 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

I found an issue with -rt patch. It is that netstat doesn't show
IPv6 sockets in ESTABLISHED state. This issue happens because a
flag bit of ebitmask is not set when the IPv6 socket connection
is established.

The fix is to set the flag bit in __inet6_hash().

Signed-off-by: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>

Index: linus-kernel.git/net/ipv6/inet6_hashtables.c
===================================================================
--- linus-kernel.git.orig/net/ipv6/inet6_hashtables.c
+++ linus-kernel.git/net/ipv6/inet6_hashtables.c
@@ -27,6 +27,8 @@ void __inet6_hash(struct inet_hashinfo *
 {
 	struct hlist_head *list;
 	rwlock_t *lock;
+	unsigned long *bitmask = NULL;
+	unsigned int index = 0;

 	BUG_TRAP(sk_unhashed(sk));

@@ -35,15 +37,16 @@ void __inet6_hash(struct inet_hashinfo *
 		lock = &hashinfo->lhash_lock;
 		inet_listen_wlock(hashinfo);
 	} else {
-		unsigned int hash;
-		sk->sk_hash = hash = inet6_sk_ehashfn(sk);
-		hash &= (hashinfo->ehash_size - 1);
-		list = &hashinfo->ehash[hash].chain;
-		lock = &hashinfo->ehash[hash].lock;
+		sk->sk_hash = inet6_sk_ehashfn(sk);
+		index = inet_ehash_index(hashinfo, sk->sk_hash);
+		list = &hashinfo->ehash[index].chain;
+		lock = &hashinfo->ehash[index].lock;
+		bitmask = hashinfo->ebitmask;
 		write_lock(lock);
 	}

 	__sk_add_node(sk, list);
+	__inet_hash_setbit(bitmask, index);
 	sock_prot_inc_use(sk->sk_prot);
 	write_unlock(lock);
 }
