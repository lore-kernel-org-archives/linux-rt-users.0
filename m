From: jordan <triplesquarednine@gmail.com>
Subject: Re: "yum install ...." based instruction on building a RT kernel.
Date: Sun, 19 Sep 2010 16:00:08 -0400
Message-ID: <AANLkTikjdFvAn2QcYf6o+C4JNSvkqC=sB0z0dNmVWBfv@mail.gmail.com>
References: <4C92A00C.6050401@atl.lmco.com>
	<AANLkTi=eaPvCZmecBKT_d0C8YunJr7L6M8A7Y9pEiQK_@mail.gmail.com>
	<AANLkTi=GbDU7fKh9LvCEpjhSSMFF0syCqJVuqUERVBEJ@mail.gmail.com>
	<4C936152.5000505@64studio.com>
	<AANLkTint6iHc6DPeEVpKd0ER0XsYMDK=0yiekHGkWtWF@mail.gmail.com>
	<20100919104916.63967cc4@riff>
	<AANLkTimgte_c6rC=okyH9Oo-NSOERqAPeOHyyd1BoWvG@mail.gmail.com>
	<AANLkTi=VV+OMfbi1tvwET9DZcG7p_a=4R6kPWSfuqrMK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Clark Williams <williams@redhat.com>,
	Daniel James <daniel@64studio.com>,
	John Kacur <jkacur@redhat.com>,
	Gautam Thaker <gautam.h.thaker@lmco.com>,
	linux-rt-users@vger.kernel.org
To: Bernardo Barros <bernardobarros2@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:39735 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0ISUAJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 19 Sep 2010 16:00:09 -0400
Received: by eyb6 with SMTP id 6so1411278eyb.19
        for <linux-rt-users@vger.kernel.org>; Sun, 19 Sep 2010 13:00:08 -0700 (PDT)
In-Reply-To: <AANLkTi=VV+OMfbi1tvwET9DZcG7p_a=4R6kPWSfuqrMK@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hey Bernardo,

> Could you share your optimizations with us? I'm also runnins 2.6.34
> here (2.6.34.6-54.fc13.x86_64),
> I have problems with my rt-kernel, it freezes my system (thinkpad
> w510). Maybe something with video card or whatever, but I don't have
> the time to really investigate what is happening, so I must get the
> best from the generic kernel for now :-)

yes, i can do that.  I am however, heading off to band practice. I
will also need to dig up some resources(web-links) that will help you.
The only things i wont be able to help you that much with, is what
CFLAG optimizations to use with x86_64. Although i do have a 64bit
install on my deksotp. it is my 32bit platform that is highly-tuned,
as 32bit is better for my Wine/VST usage. Most of the settings that i
use will work fine though.
Can i assume that you are fairly tech-savvy, or have a good linux
knowledge base????

First, i will recommend checking out Zen-kernel (www.zen-kernel.org) -
* if you do not want to have to patch the kernel several times over,
this is a great option *
these guys include all the non-upstream stuff, that will be required/useful...

jordan
