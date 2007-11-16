From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: 2.6.24-rc2-rt1 - inet-hash-bits-ipv6-fix.patch
Date: Fri, 16 Nov 2007 03:23:11 -0800
Message-ID: <1195212191.3241.31.camel@sx.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: RT Users List <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, nakagawa.msy@ncos.nec.co.jp
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from victor.provo.novell.com ([137.65.250.26]:43207 "EHLO
	victor.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbXKPLXY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Nov 2007 06:23:24 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


Hello Nakagawa-san,

The above inet-hash-bits-ipv6-fix.patch in RT backs-out a hunk, that was
just pushed into Kernel.org after -rc2.

It will cause a compile error, because by the 2.6.24-rc2-git4 patch,
the.lock which ipv6-fix restores and uses, disappears.

I'm not sure about the locking, so I thought I'd mention it, since you
have stepped through all this before.

Regards,

Sven

Here are the 2 conflicting hunks...

>From patches.rt/inet-hash-bits-ipv6-fix.patch:
@@ -35,14 +37,16 @@ void __inet6_hash(struct inet_hashinfo *
                lock = &hashinfo->lhash_lock;
                inet_listen_wlock(hashinfo);
        } else {
-               unsigned int hash;
-               sk->sk_hash = hash = inet6_sk_ehashfn(sk);
-               list = &inet_ehash_bucket(hashinfo, hash)->chain;
-               lock = inet_ehash_lockp(hashinfo, hash);
+               sk->sk_hash = inet6_sk_ehashfn(sk);
+               index = inet_ehash_index(hashinfo, sk->sk_hash);
+               list = &hashinfo->ehash[index].chain;
+               lock = &hashinfo->ehash[index].lock;
+               bitmask = hashinfo->ebitmask;
                write_lock(lock);
        }

        __sk_add_node(sk, list);
+       __inet_hash_setbit(bitmask, index);
        sock_prot_inc_use(sk->sk_prot);
        write_unlock(lock);

Git 4:
index 4427dcd..469216d 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -23,6 +23,7 @@
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/vmalloc.h>

 #include <net/inet_connection_sock.h>
 #include <net/inet_sock.h>
@@ -37,7 +38,6 @@
  * I'll experiment with dynamic table growth later.
  */
 struct inet_ehash_bucket {
-       rwlock_t          lock;
        struct hlist_head chain;
        struct hlist_head twchain;
 };

diff --git a/net/ipv6/inet6_hashtables.c b/net/ipv6/inet6_hashtables.c
index d6f1026..adc73ad 100644
--- a/net/ipv6/inet6_hashtables.c
+++ b/net/ipv6/inet6_hashtables.c
@@ -37,9 +37,8 @@ void __inet6_hash(struct inet_hashinfo *hashinfo,
        } else {
                unsigned int hash; 
                sk->sk_hash = hash = inet6_sk_ehashfn(sk);
-               hash &= (hashinfo->ehash_size - 1);
-               list = &hashinfo->ehash[hash].chain;
-               lock = &hashinfo->ehash[hash].lock;
+               list = &inet_ehash_bucket(hashinfo, hash)->chain;
+               lock = inet_ehash_lockp(hashinfo, hash);
                write_lock(lock);
        }






-- 
Sven-Thorsten Dietrich
+1 415 694-2930
( www.novell.com/linux )
