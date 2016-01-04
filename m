From: Khem Raj <raj.khem@gmail.com>
Subject: Re: [PATCH] Makefile: Set CC/AR variable only if it doesn't have a value
Date: Mon, 4 Jan 2016 15:13:08 -0800
Message-ID: <CAMKF1srY=8SSjdK6qxCtn866XEp+o8sqbHJXMQMFzyt5LwZ_WA@mail.gmail.com>
References: <1451847271-31571-1-git-send-email-raj.khem@gmail.com>
 <20160104133903.GG92593@unpythonic.net> <186FF0A1-B6ED-49CA-B83F-3335126F671B@gmail.com>
 <568AC64B.7040107@essensium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff Epler <jepler@unpythonic.net>, williams@redhat.com,
	jkacur@redhat.com, linux-rt-users@vger.kernel.org
To: Arnout Vandecappelle <arnout.vandecappelle@essensium.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:33563 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbcADXNi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 4 Jan 2016 18:13:38 -0500
Received: by mail-ig0-f176.google.com with SMTP id mv3so2225283igc.0
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jan 2016 15:13:38 -0800 (PST)
In-Reply-To: <568AC64B.7040107@essensium.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Jan 4, 2016 at 11:21 AM, Arnout Vandecappelle
<arnout.vandecappelle@essensium.com> wrote:
> On 04-01-16 17:20, Khem Raj wrote:
>>> On Jan 4, 2016, at 5:39 AM, Jeff Epler <jepler@unpythonic.net> wrote:
>>> >
>>> > I believe the patch does not have the desired effect, because make(1)
>>> > always sets CC automatically:
>>> >
>>> > $ cat raj.mk
>>> > CROSS_COMPILE=x86_64-linux-gnu-
>>> > CC?=$(CROSS_COMPILE)gcc
>>> > .PHONY: default
>>> > default:
>>> >    @echo CC=$(CC)
>>> > $ make -f raj.mk
>>> > CC=cc
>>> >
>>> > With your patch, those who specify CROSS_COMPILE, or for whom gcc and cc
>>> > are different, will get different (worse) behavior.
>> Right. I think if CC was used as such with out constructing out of CROSS_COMPILE
>> in Makefile then my issue would be fixed too. However this would mean that cross compiling users
>> now have to pass CC = <cross-compiler> themselves instead of CROSS_COMPILE prefix. Is that
>> acceptable ?
>
>  But what is really your issue? Even after this patch, you'll have to run
>
> make CC=<path-to-clang> AR=<path-to-clang-ar>
>
> and this will already override it in the current situation.

currently it ignores CC from environment. So there is no way to
specify a compiler which is not called {something}gcc

>
