From: John Kacur <jkacur@redhat.com>
Subject: Re: patch-2.6.33-rt4 does not apply to linux-2.6.33 vanilla sources
Date: Wed, 10 Mar 2010 14:13:57 +0100
Message-ID: <520f0cf11003100513t6792801kc7d078e780422381@mail.gmail.com>
References: <4B97887F.7030303@grinta.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: RT-users <linux-rt-users@vger.kernel.org>
To: Daniele Nicolodi <daniele@grinta.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:47566 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763Ab0CJNN7 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 10 Mar 2010 08:13:59 -0500
Received: by ey-out-2122.google.com with SMTP id 25so1071871eya.19
        for <linux-rt-users@vger.kernel.org>; Wed, 10 Mar 2010 05:13:58 -0800 (PST)
In-Reply-To: <4B97887F.7030303@grinta.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 10, 2010 at 12:54 PM, Daniele Nicolodi <daniele@grinta.net> wrote:
> Hello. I just downloaded linux-2.6.33.tar.bz2 and patch-2.6.33-rt4 from
> kernel.org. However, the patch does not apply to the downloaded sources.
>
> I am missing something, or there may be a problem?
>

It should work. Do something like the following.

tar xjf linux-2.6.33.tar.bz2
cd linux-2.6.33
bunzip2 -c ../patch-2.6.33-rt4.bz2 | patch -p1
