From: Daniel Walker <dwalker@mvista.com>
Subject: v2.6.22.1-rt4-dw2
Date: Sun, 22 Jul 2007 11:03:59 -0700
Message-ID: <1185127439.2573.21.camel@imap.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	sven@thebigcorporation.com
To: mingo@elte.hu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759670AbXGVSOn@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


I released another version of my tree .. It's still based on
2.6.22.1-rt4 . It's even more bisectable, but still not fully
bisectable.

I included the two fixes I post earlier today,

[PATCH -rt] temporary WARN_ON removal
[PATCH -rt] drop spurious rcu unlock

Here's the combined patch,

ftp://source.mvista.com/pub/dwalker/rt/patch-2.6.22.1-rt4-dw2

And the broken out set,

ftp://source.mvista.com/pub/dwalker/rt/patch-2.6.22.1-rt4-dw2-broken-out.tar.gz


The release notes for 2.6.22.1-rt4 also apply to this patch.

Daniel
