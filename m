From: =?UTF-8?B?SmFyb23DrXIgTWlrZcWh?= <mira.mikes@gmail.com>
Subject: Re: debian RT kernel
Date: Tue, 19 May 2015 20:45:58 +0200
Message-ID: <CAG_ZyaDHeu11MYGRveTcaEz+QyRR7=ZcuuN4ke4RJV3EfVNKnQ@mail.gmail.com>
References: <CAG_ZyaA83dFKKvEsNhzyGkjrbsY=_mFBGjmg+M1-+MPo=-hOUw@mail.gmail.com>
	<20150519115633.55ec7739@gandalf.local.home>
	<1432054729.12412.26.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:34563 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261AbbESSp7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 19 May 2015 14:45:59 -0400
Received: by oiko83 with SMTP id o83so18355185oik.1
        for <linux-rt-users@vger.kernel.org>; Tue, 19 May 2015 11:45:58 -0700 (PDT)
In-Reply-To: <1432054729.12412.26.camel@decadent.org.uk>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2015-05-19 18:58 GMT+02:00 Ben Hutchings <ben@decadent.org.uk>:
> On Tue, 2015-05-19 at 11:56 -0400, Steven Rostedt wrote:
>> On Mon, 18 May 2015 22:13:40 +0200
>> Jarom=C3=ADr Mike=C5=A1 <mira.mikes@gmail.com> wrote:
>>
>> > Hi all,
>> >
>> > We quite recently had RT in debian easily accessible for all users
>> > what I personally consider to be great achievement.
>> > But because RT development interruption we don't have fresh RT ker=
nels anymore.
>> >
>> > Pengutronix provided debian packages of RT kernels before.
>> > Is there any place where to get debian packages of RT kernels?
>> >
>>
>> I believe Ben is the one that maintains the RT kernels in Debian.

I know that Ben is doing great work in maintaining debian kernels.

> I built kernel packages with the RT patch set whenever it was availab=
le
> for the upstream version we were using for standard kernel packages.

> Unfortunately there is no patch set for Linux 3.16 as used in Debian =
8
> 'jessie' or for Linux 4.0 which is currently in unstable.

I also know that there are not currently patches against 4.0 kernel
which is in debian "sid"
Would be great if Ben's work and work of rt-kernel developers could be
synced again as it was before 3.16

Do you (rt devs) plan make patches again for latest kernels as you
have done before?

> Older versions are available from
> <http://snapshot.debian.org/package/linux/> but they will have known
> security issues.

I am still using linux-image-3.14-2-amd64 which is already bit
outdated ... I am having some issues to boot it on my debian "testing"
machine.

best regards

mira
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
