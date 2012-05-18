From: John Kacur <jkacur@redhat.com>
Subject: Re: Preemption test
Date: Fri, 18 May 2012 14:49:04 +0200
Message-ID: <CAONaPpEvdJJOfrZo_Z=M2n62U-gzY2JyR58YO6nAoNE4kN_h7w@mail.gmail.com>
References: <4FB2BCFC.7040104@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: RT <linux-rt-users@vger.kernel.org>
To: Venkat Subbiah <vsubbiah@caviumnetworks.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:37391 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759720Ab2ERMtG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 May 2012 08:49:06 -0400
Received: by vbbff1 with SMTP id ff1so2487384vbb.19
        for <linux-rt-users@vger.kernel.org>; Fri, 18 May 2012 05:49:04 -0700 (PDT)
In-Reply-To: <4FB2BCFC.7040104@caviumnetworks.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, May 15, 2012 at 10:30 PM, Venkat Subbiah
<vsubbiah@caviumnetworks.com> wrote:
> Trying to compile Preepmtion test with instructions from
> https://rt.wiki.kernel.org/index.php/Preemption_Test and I run into t=
he
> error below
>
> g++ preempt-test.cc -g -lboost_thread-mt -lboost_program_options -o
> preempt-test
> preempt-test.cc:57:40: error: boost/thread/detail/lock.hpp: No such f=
ile or
> directory
>
> Is there a later version than v4 from
> ftp://ftp.novell.com/dev/ghaskins/preempt-test-latest.tar.bz2
>
> The git link
> =A0git://git.kernel.org/pub/scm/linux/kernel/git/ghaskins/preempt-tes=
t.git
> doesn't exist. Is there a git repo some where else.
>

No idea if anyone is actively maintaining the "Preemption Test".
Most folks here use the rt-tests suite. The Wiki page for Preemption
Test acknowledges rt-migration-test for ideas in it's own development.
The rt-migration-test itself is now actively maintained as part of the
rt-test suite.
I updated the wiki to reflect that fact with a link to rt-tests.

Thanks
John
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
