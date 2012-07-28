From: Peter LaDow <petela@gocougs.wsu.edu>
Subject: Process Hang in __read_seqcount_begin
Date: Sat, 28 Jul 2012 13:43:01 -0700
Message-ID: <CAN8Q1EdcrHtnTQYq0Tj9Oy3nevcSkQPMyY=O0dhG45T7JwEMKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54828 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753087Ab2G1UnD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 28 Jul 2012 16:43:03 -0400
Received: by wgbdr13 with SMTP id dr13so3733267wgb.1
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Jul 2012 13:43:02 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

We are running 3.0.36-rt57 on a powerpc box.  During some testing with
heavy loads and interfaces coming up/going down (specifically PPP), we
have run into a case where iptables hangs and cannot be killed.  It
requires a reboot to fix the problem.

Connecting the BDI and debugging the kernel, we get:

#0  get_counters (t=0xdd5145a0, counters=0xe3458000)
    at include/linux/seqlock.h:66
#1  0xc026b4ac in do_ipt_get_ctl (sk=<value optimized out>,
    cmd=<value optimized out>, user=0x10612078, len=<value optimized out>)
    at net/ipv4/netfilter/ip_tables.c:918
#2  0xc022226c in nf_sockopt (sk=<value optimized out>, pf=2 '\002',
    val=<value optimized out>, opt=<value optimized out>, len=0xdd4c7d4c,
    get=1) at net/netfilter/nf_sockopt.c:109
#3  0xc0236b1c in ip_getsockopt (sk=0xdf071480, level=<value optimized out>,
    optname=65, optval=0x10612078 <Address 0x10612078 out of bounds>,
    optlen=0xbfbe0c2c) at net/ipv4/ip_sockglue.c:1308
#4  0xc02522a8 in raw_getsockopt (sk=0xdf071480, level=<value optimized out>,
    optname=<value optimized out>, optval=<value optimized out>,
    optlen=<value optimized out>) at net/ipv4/raw.c:811
#5  0xc01f4c38 in sock_common_getsockopt (sock=<value optimized out>,
    level=<value optimized out>, optname=<value optimized out>,
    optval=<value optimized out>, optlen=<value optimized out>)
    at net/core/sock.c:2157
#6  0xc01f2df8 in sys_getsockopt (fd=<value optimized out>, level=0,
    optname=65, optval=0x10612078 <Address 0x10612078 out of bounds>,
    optlen=0xbfbe0c2c) at net/socket.c:1839
#7  0xc01f45b4 in sys_socketcall (call=15, args=<value optimized out>)
    at net/socket.c:2421

It seems to be stuck in __read_seqcount_begin.  From include/linux/seqlock.h:

static inline unsigned __read_seqcount_begin(const seqcount_t *s)
{
        unsigned ret;

repeat:
        ret = ACCESS_ONCE(s->sequence);
        if (unlikely(ret & 1)) {
                cpu_relax();
  <----- It is always here
                goto repeat;
        }
        return ret;
}

I've been scouring the mailing lists and Google searches trying to
find something, but thus far have come up with nothing.

Any tips would be appreciated.

Thanks,
Pete
