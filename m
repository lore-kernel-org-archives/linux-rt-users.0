From: Patrik Lundquist <patrik.lundquist@gmail.com>
Subject: Re: Operation not permitted / pthread_setschedparam
Date: Wed, 1 Oct 2014 09:49:14 +0200
Message-ID: <CAA7pwKPcT_YvQx9_nvSXCq3sFB3aCRZ-mGWTk4GOvLn0k7c3_w@mail.gmail.com>
References: <542A88A8.7060800@steinhoff.de>
	<alpine.DEB.2.11.1410010058160.4455@nanos>
	<542BACF1.3090405@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35126 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaJAHtQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 1 Oct 2014 03:49:16 -0400
Received: by mail-wi0-f171.google.com with SMTP id ho1so1016010wib.4
        for <linux-rt-users@vger.kernel.org>; Wed, 01 Oct 2014 00:49:14 -0700 (PDT)
In-Reply-To: <542BACF1.3090405@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 1 October 2014 09:27, Armin Steinhoff <armin@steinhoff.de> wrote:
> Thomas Gleixner schrieb:
>> On Tue, 30 Sep 2014, Armin Steinhoff wrote:
>>> How to solve that problem ?
>> Hint #1: 3.4.0-rc7-rt7-2.16
> I'm using the vanilla kernel "linux-3.4-rc7.tar.gz" and the related(?)
> RT patch "patch-3.4-rt7.patch.xz" from "kernel.org"

Try linux-3.4.97.tar.xz with patch-3.4.97-rt121.patch.xz
