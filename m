From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2.6.21.5-rt17] IPV6: estalished connections are not
	shown with "cat /proc/net/tcp6"
Date: Sat, 23 Jun 2007 08:25:48 -0400
Message-ID: <1182601548.5493.117.camel@localhost.localdomain>
References: <467C40D3.206@ncos.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, linux-rt-users@vger.kernel.org, dwalker@mvista.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Lee Revell <rlrevell@joe-job.com>
To: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:60041 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbXFWM0t (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Jun 2007 08:26:49 -0400
In-Reply-To: <467C40D3.206@ncos.nec.co.jp>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Wow, a blast from the past :-)

I'm the original author of the hash code, and since I don't use ipv6
(yet) I must have missed it in my testing.

On Fri, 2007-06-22 at 14:36 -0700, Masayuki Nakagawa wrote:
> I found an issue regarding networking in the real-time patch (patch-2.6.21.5-rt17).
> The issue happens only with the kernel, which the real-time patch was applied.
> However, the latest stable main kernel (2.6.21.5) doesn't have the same issue.
> Therefore, please don't transfer this report to netdev.
> 
> The detail of issue is below.
> I ran my test program, which is a very simple IPv6 client-server program.
> These programs establish a TCP/IPv6 connection between two hosts, and then sleep,
> like following diagram.
> And then, the problem appears with "cat /proc/net/tcp6".
> 
>     serverA          serverB
>        |      SYN       |
>        +--------------->+
>        |    SYN/ACK     |
>        +<---------------+
>        |      ACK       |
>        +--------------->+
>        |                |
>      sleep...         sleep...
>        |                |
> 
> When I "cat /proc/net/tcp6" on serverA while establishing connection between serverA and B,
> the established connections are not shown.
> If you need my test program, please let me know. I can provide it to you.
> 
> However, in case of the main-line kernel, the established connections will be
> shown appropriately with "cat /proc/net/tcp6". It's different because the
> real-time patch has implemented a new socket lookup mechanism for a high-latency.
> So, real-time patch has a different mechanism from main-line kernel.
> 
> The real-time patch, which implemented a new socket lookup mechanism is using
> bitmap(ebitmask). When establishing TCP connection, it sets a flag bit into
> the bitmap like followings.
> 
> [ebitmask in struct inet_hashinfo]
>  Before connecting
>   0000000000000000000000000000000000000000000000000000000000000000
>  After connecting
>   0000001000000000000000000000000000000000000000000000000000000000
>         ^
> 
> And when reading "/proc/net/tcp and tcp6", the kernel searches the currently active
> TCP connections with reference to the bitmap.
> 
> However, the kernel can't search the active TCP/IPv6 connection in established state.
> It is because the kernel doesn't set a flag bit when establishing TCP/IPv6 connection.
> In case of TCP/IPv4, __inet_hash() sets the flag bit properly with __inet_hash_setbit().
> But, in case of TCP/IPv6, the setting the flag bit is missing in __inet6_hash().
> 
> [include/net/inet_hashtables.h]
> static inline void __inet_hash(struct inet_hashinfo *hashinfo,
>                                struct sock *sk, const int listen_possible)
> {
>         struct hlist_head *list;
>         rwlock_t *lock;
>         unsigned long *bitmask = NULL;
>         unsigned int index = 0;
> 
>         BUG_TRAP(sk_unhashed(sk));
>         if (listen_possible && sk->sk_state == TCP_LISTEN) {
>                 list = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
>                 lock = &hashinfo->lhash_lock;
>                 inet_listen_wlock(hashinfo);
>         } else {
>                 struct inet_ehash_bucket *head;
>                 sk->sk_hash = inet_sk_ehashfn(sk);
>                 index = inet_ehash_index(hashinfo, sk->sk_hash);
>                 head = inet_ehash_bucket(hashinfo, sk->sk_hash);
>                 list = &head->chain;
>                 lock = &head->lock;
>                 bitmask = hashinfo->ebitmask;
>                 write_lock(lock);
>         }
>         __sk_add_node(sk, list);
>         __inet_hash_setbit(bitmask, index);
>         sock_prot_inc_use(sk->sk_prot);
>         write_unlock(lock);
>         if (listen_possible && sk->sk_state == TCP_LISTEN)
>                 wake_up(&hashinfo->lhash_wait);
> }
> 
> [net/ipv6/inet6_hashtables.c]
> void __inet6_hash(struct inet_hashinfo *hashinfo,
>                                 struct sock *sk)
> {
>         struct hlist_head *list;
>         rwlock_t *lock;
> 
>         printk("__inet6_hash hit\n");
> 
>         BUG_TRAP(sk_unhashed(sk));
> 
>         if (sk->sk_state == TCP_LISTEN) {
>                 list = &hashinfo->listening_hash[inet_sk_listen_hashfn(sk)];
>                 lock = &hashinfo->lhash_lock;
>                 inet_listen_wlock(hashinfo);
>         } else {
>                 unsigned int hash;
>                 sk->sk_hash = hash = inet6_sk_ehashfn(sk);
>                 hash &= (hashinfo->ehash_size - 1);
>                 list = &hashinfo->ehash[hash].chain;
>                 lock = &hashinfo->ehash[hash].lock;
>                 write_lock(lock);
>         }
> 
>         __sk_add_node(sk, list);
>         sock_prot_inc_use(sk->sk_prot);
>         write_unlock(lock);
> }
> 
> So, I suggest a following change.
> The change is to set the flag bit appropriately in __inet6_hash().
> 
> Signed-off-by: Masayuki Nakagawa <nakagawa.msy@ncos.nec.co.jp>
> 

Very nice investigation and solution.

> 
> Index: linus-kernel.git/net/ipv6/inet6_hashtables.c
> ===================================================================
> --- linus-kernel.git.orig/net/ipv6/inet6_hashtables.c
> +++ linus-kernel.git/net/ipv6/inet6_hashtables.c
> @@ -27,6 +27,8 @@ void __inet6_hash(struct inet_hashinfo *
>  {
>  	struct hlist_head *list;
>  	rwlock_t *lock;
> +	unsigned long *bitmask = NULL;
> +	unsigned int index = 0;
> 
>  	BUG_TRAP(sk_unhashed(sk));
> 
> @@ -35,15 +37,16 @@ void __inet6_hash(struct inet_hashinfo *
>  		lock = &hashinfo->lhash_lock;
>  		inet_listen_wlock(hashinfo);
>  	} else {
> -		unsigned int hash;
> -		sk->sk_hash = hash = inet6_sk_ehashfn(sk);
> -		hash &= (hashinfo->ehash_size - 1);
> -		list = &hashinfo->ehash[hash].chain;
> -		lock = &hashinfo->ehash[hash].lock;
> +		sk->sk_hash = inet6_sk_ehashfn(sk);
> +		index = inet_ehash_index(hashinfo, sk->sk_hash);
> +		list = &hashinfo->ehash[index].chain;
> +		lock = &hashinfo->ehash[index].lock;
> +		bitmask = hashinfo->ebitmask;
>  		write_lock(lock);
>  	}
> 
>  	__sk_add_node(sk, list);
> +	__inet_hash_setbit(bitmask, index);
>  	sock_prot_inc_use(sk->sk_prot);
>  	write_unlock(lock);
>  }

I spent a few minutes looking at your changes and I don't see anything
wrong with it.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

Looking at the original patch, here's the reason for the bitmask:

--- linux-2.6.21.orig/net/ipv4/tcp_ipv4.c       2007-06-17 17:19:02.000000000 +0200
+++ linux-2.6.21/net/ipv4/tcp_ipv4.c    2007-06-17 17:20:27.000000000 +0200
@@ -2033,7 +2033,12 @@ static void *established_get_first(struc
        struct tcp_iter_state* st = seq->private;
        void *rc = NULL;

-       for (st->bucket = 0; st->bucket < tcp_hashinfo.ehash_size; ++st->bucket) {

The above is a linear search through out a very large array, where most
of the items are NULL.  I believe it was Lee that noticed this creating
a large latency. This was back in 2.6.14. I'll check to see if this
still is a source of latency with the latest kernels.

-- Steve


+       for (st->bucket = find_first_bit(tcp_hashinfo.ebitmask,
+                                        tcp_hashinfo.ehash_size);
+            st->bucket < tcp_hashinfo.ehash_size;
+            st->bucket = find_next_bit(tcp_hashinfo.ebitmask,
+                                       tcp_hashinfo.ehash_size,
+                                       st->bucket+1)) {
