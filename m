Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39319 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbeHXKOj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Aug 2018 06:14:39 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so4065296pff.6
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Aug 2018 23:41:26 -0700 (PDT)
Subject: Re: kernel freeze when running docker
References: <CAH3OF51v8_KK_XF_sttVzSddmWoLUvVOjbUvKr2OuiJTLntTQQ@mail.gmail.com>
 <20180821012731.GB8562@jcartwri.amer.corp.natinst.com>
 <CAH3OF50F26ywGHZ2Rfa7v-SeoZ6KccSPt+1uNq65eBNTqom=-A@mail.gmail.com>
 <20180821134221.GC8562@jcartwri.amer.corp.natinst.com>
 <d4b10821-ccd1-79cb-f337-403077aba2f6@gmail.com>
 <20180822164235.GR1123@jcartwri.amer.corp.natinst.com>
From: Vignesh Raman <vignesh.raman.in@gmail.com>
Message-ID: <7f76ebbb-956f-1685-6663-1363d3039e78@gmail.com>
Date: Fri, 24 Aug 2018 12:11:18 +0530
MIME-Version: 1.0
In-Reply-To: <20180822164235.GR1123@jcartwri.amer.corp.natinst.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Cc: linux-rt-users@vger.kernel.org

Hi Julia,

On Wednesday 22 August 2018 10:12 PM, Julia Cartwright wrote:
> I never explicitly asked...have you tried a similar test on a non-RT
> kernel?  Does it exhibit the same behavior?  The linked moby github
> issue would seem to indicate this isn't RT specific...

Yes I tried the tests on non-RT kernel and the issue was not reproduced
with 14 hours of testing with docker running kubernetes. I also tested
with the test case mentioned in moby github issue and the kernel freeze
was not seen. Config file is https://paste.debian.net/1039104/

root@debian:~# uname -a
Linux debian 4.9.0-6-amd64 #1 SMP Debian 4.9.82-1+deb9u3 (2018-03-02)
x86_64 GNU/Linux

> Can you send your full config?  If I get some time to try it, I'd like
> to see if I can reproduce your issue.

Thanks. Config file is https://paste.debian.net/1039103/ (output of
'grep "=[y|m]" config-4.14.59-rt37')
This issue was reproduced with 4.9.0-6-rt-amd64 kernel also.

root@debian:~# uname -a
Linux debian 4.14.59-rt37 #1 SMP PREEMPT RT Fri Aug 24 00:31:29 UTC 2018
x86_64 GNU/Linux

Below are the steps to reproduce the issue,
Install docker using,
curl
https://raw.githubusercontent.com/rancher/install-docker/master/17.03.2.sh
| /bin/bash

Run
"for f in $(seq 1 10000);do docker run -it --rm ubuntu echo $f; done"
consecutively in 3 terminals.

The freeze/lockup occurs sporadically.

The other test case is to run docker with kubernetes.

Regards,
Vignesh
