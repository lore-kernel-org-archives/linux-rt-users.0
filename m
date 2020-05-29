Return-Path: <SRS0=xga9=7L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4B4C433DF
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313422077D
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 May 2020 19:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="US/i+nWy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgE2TDa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 May 2020 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgE2TDa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 May 2020 15:03:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E3DC03E969;
        Fri, 29 May 2020 12:03:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f185so5033110wmf.3;
        Fri, 29 May 2020 12:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lBBxb96beAwkIgYdzLJSkA8SqCiasuxaii/bMEuftuQ=;
        b=US/i+nWyixOd5BlnDoGRQf92jK5rLBFQOimtlgfF0h+NUHP1t2DVMYPViT3BuNkiQS
         zVNxPxM4xcPHeqyyWvpveTTRFcLYhd040sHmJ/Jeo+2/qsxijrf8dy1uAOy9/HQE2Yod
         rRfmMWetxigAkhdJCLO6cwGfRW2PVUBc2heOOC4teieSFuHIXBy6ZTPY+7j+utLGEbDT
         CbcC/DTbVZ09Doj3EHyBN/TSMxfaGulOxA90pJW904UfDGefnhTq+JPH8UoxtXoch2xY
         bWO0/sBgZvCRDAUavnpoK7zjEufWOQtX1Fe01LXmxHzbdB9wN2loyJTS+jOSOu53ZvHf
         EDhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lBBxb96beAwkIgYdzLJSkA8SqCiasuxaii/bMEuftuQ=;
        b=T51SM5m+HZ38QWXDCpn7tskxlenRVoDc6BB42e3ogILdNeButm4ByOPYH8B0FLoItH
         Nt5INrL/NhvcMtgV+Lpx0jAsW+th1zNvAskB4ChMIbN12q97rpRoVXCDtt4sZywjpmyU
         jG5kthHdLIwsozMvL2JBYO3/Sm6Lfisa7uvx6nI9CVI80DXJJiFEtUVRxPGVgGvoRSY4
         4oeg5v68RAlARt6edJBbqFYVI8U4T245DCUkfcRT+xNaN8EY2GJs4gKKUDFVvh3bY50i
         Hsso5e3g3kV2iG7fblPqjsc+56LSyFb0QkrVZop/v+P3WOMhgZZ8y5lQJXeFZ1avAIhz
         36Fg==
X-Gm-Message-State: AOAM533daU8GzZteBVOQtk8VmNVo9IuCbVbXXpG1iGXHABwKqK+4uY+z
        7E/lEYKiYTbCnUd0mlZCyjoU8O7rurePXrL04X3o14jH
X-Google-Smtp-Source: ABdhPJz26URIA+5j/vBGr0h3IyFQhL2lWXGHENS9kUh8U49aP9Aa1C/Sx5OmLLjcbBKCAaAD3UFLqQU9jFeCsOByE9U=
X-Received: by 2002:a1c:6042:: with SMTP id u63mr9742337wmb.65.1590779008849;
 Fri, 29 May 2020 12:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAD4b4WK9W+dNZZ_WPt-9ZNpSHvyxdwPW86Rtq4AKOONuvyR37A@mail.gmail.com>
 <20200529131452.pgj7mx7xaz7n4kz3@linutronix.de> <CAD4b4WLS36JKepz31m98Z3Ve05d63GnfBGsuuWRXpjXZqPoBrA@mail.gmail.com>
 <20200529161518.svpxhkeljafbtdz2@linutronix.de>
In-Reply-To: <20200529161518.svpxhkeljafbtdz2@linutronix.de>
From:   Mark Marshall <markmarshall14@gmail.com>
Date:   Fri, 29 May 2020 21:03:17 +0200
Message-ID: <CAD4b4WLk0E92kBTk-VR7pKbfWwKgB9+h1Qq+DxgF7p-BPofC6A@mail.gmail.com>
Subject: Re: Kernel crash due to memory corruption with v5.4.26-rt17 and
 PowerPC e500
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mark Marshall <mark.marshall@omicronenergy.com>,
        thomas.graziadei@omicronenergy.com,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org
Content-Type: multipart/mixed; boundary="000000000000bd340605a6ce1984"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--000000000000bd340605a6ce1984
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My config is attached.  This is the greatly reduced config that I used
when trying to narrow down the problem.  We normally have much more
enabled, but that had no effect on the bug in my testing.  We do,
unfortunately, have quite a few out-of-tree patches, but they are all
in USB or Networking, which are disabled here.

I've never tried out the kernel under qemu, but I will try that next
week to see if I can reproduce the problem there.  It's certainly
quite a narrow race window though, so it might behave quite
differently under qemu.  In general, how reliable is qemu at showing
these kinds of problems?

Thanks,
Mark

PS.
I've also noticed that THREAD_SHIFT is set in this config.  That's
because when I added lots of debug options, I got warnings about the
stack being too small.  This had no impact on the bug that I had, I
increased the size of the stack, and the stack warnings stopped, but
the bug was still the same.

On Fri, 29 May 2020 at 18:15, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-05-29 17:38:39 [+0200], Mark Marshall wrote:
> > Hi Sebastian & list,
> Hi,
>
> > I had assumed that my e-mail had got lost or overlooked, I was meaning =
to
> > post a follow up message this week...
> >
> > All I could find from the debugging and tracing that we added was that
> > something was going wrong with the mm data structures somewhere in the
> > exec code.  In the end I just spent a week or two pouring over the diff=
s
> > of this code between the versions that I new worked and didn't work.
> >
> > I eventually found the culprit.  On the working kernel versions there i=
s
> > a patch called "mm: Protect activate_mm() by preempt_[disable&enable]_r=
t()".
> > This is commit f0b4a9cb253a on the V4.19.82-rt30 branch, for instance.
> > Although the commit message talks about ARM, it seems that we need this=
 for
> > PowerPC too (I guess, any PowerPC with the "nohash" MMU?).
>
> Could you drop me your config, please? I need to dig here a little and I
> should have seen this on qemu, right?
>
> > Could you please add this commit back to the RT branch?  I'm not sure h=
ow
> > to find out the history of this commit.  For instance, why has it been
> > removed from the RT patchset?  How are these things tracked, generally?
>
> I dropped that patch in v5.4.3-rt1. I couldn't reproduce the issue that
> was documented in the patch and the code that triggered the warning was
> removed / reworked in commit
>     b5466f8728527 ("ARM: mm: remove IPI broadcasting on ASID rollover")
>
> So it looked like no longer needed and then got dropped during the
> rebase.
> In order to get it back into the RT queue I need to understand why it is
> required. What exactly is it fixing. Let me stare at for a little=E2=80=
=A6
>
> > Best regards,
> > Mark
>
> Sebastian

--000000000000bd340605a6ce1984
Content-Type: application/octet-stream; name="config-5.4-rt"
Content-Disposition: attachment; filename="config-5.4-rt"
Content-Transfer-Encoding: base64
Content-ID: <f_kaskihor0>
X-Attachment-Id: f_kaskihor0

IyBDT05GSUdfU1dBUCBpcyBub3Qgc2V0CkNPTkZJR19TWVNWSVBDPXkKQ09ORklHX0hJR0hfUkVT
X1RJTUVSUz15CkNPTkZJR19QUkVFTVBUX1JUPXkKQ09ORklHX0lSUV9USU1FX0FDQ09VTlRJTkc9
eQpDT05GSUdfQlNEX1BST0NFU1NfQUNDVD15CkNPTkZJR19CU0RfUFJPQ0VTU19BQ0NUX1YzPXkK
Q09ORklHX1JDVV9FWFBFUlQ9eQpDT05GSUdfSUtDT05GSUc9eQpDT05GSUdfSUtDT05GSUdfUFJP
Qz15CkNPTkZJR19CTEtfREVWX0lOSVRSRD15CiMgQ09ORklHX1JEX0JaSVAyIGlzIG5vdCBzZXQK
IyBDT05GSUdfUkRfTFpNQSBpcyBub3Qgc2V0CiMgQ09ORklHX1JEX1haIGlzIG5vdCBzZXQKIyBD
T05GSUdfUkRfTFpPIGlzIG5vdCBzZXQKIyBDT05GSUdfUkRfTFo0IGlzIG5vdCBzZXQKIyBDT05G
SUdfU0dFVE1BU0tfU1lTQ0FMTCBpcyBub3Qgc2V0CiMgQ09ORklHX1NZU0ZTX1NZU0NBTEwgaXMg
bm90IHNldApDT05GSUdfS0FMTFNZTVNfQUxMPXkKQ09ORklHX0JQRl9TWVNDQUxMPXkKIyBDT05G
SUdfUlNFUSBpcyBub3Qgc2V0CkNPTkZJR19FTUJFRERFRD15CkNPTkZJR19QRVJGX0VWRU5UUz15
CiMgQ09ORklHX0NPTVBBVF9CUksgaXMgbm90IHNldApDT05GSUdfUFBDXzg1eHg9eQpDT05GSUdf
TVBDODV4eF9EUz15CkNPTkZJR19NUEM4NXh4X1JEQj15CkNPTkZJR19QMTAxMF9SREI9eQpDT05G
SUdfTUFJTzQwMD15CkNPTkZJR19NSUM0MDA9eQpDT05GSUdfR0VOX1JUQz15CkNPTkZJR19IWl8x
MDAwPXkKQ09ORklHX1RIUkVBRF9TSElGVD0xNAojIENPTkZJR19TVVNQRU5EIGlzIG5vdCBzZXQK
IyBDT05GSUdfU0VDQ09NUCBpcyBub3Qgc2V0CkNPTkZJR19GU0xfTEJDPXkKQ09ORklHX0pVTVBf
TEFCRUw9eQpDT05GSUdfU1RSSUNUX0tFUk5FTF9SV1g9eQpDT05GSUdfTU9EVUxFUz15CkNPTkZJ
R19NT0RVTEVfVU5MT0FEPXkKQ09ORklHX01PRFVMRV9GT1JDRV9VTkxPQUQ9eQpDT05GSUdfTU9E
VkVSU0lPTlM9eQojIENPTkZJR19CTEtfREVWX0JTRyBpcyBub3Qgc2V0CkNPTkZJR19CTEtfREVW
X0lOVEVHUklUWT15CiMgQ09ORklHX01RX0lPU0NIRURfREVBRExJTkUgaXMgbm90IHNldAojIENP
TkZJR19NUV9JT1NDSEVEX0tZQkVSIGlzIG5vdCBzZXQKIyBDT05GSUdfQ09SRV9EVU1QX0RFRkFV
TFRfRUxGX0hFQURFUlMgaXMgbm90IHNldAojIENPTkZJR19DT01QQUNUSU9OIGlzIG5vdCBzZXQK
IyBDT05GSUdfTUlHUkFUSU9OIGlzIG5vdCBzZXQKQ09ORklHX1VFVkVOVF9IRUxQRVI9eQpDT05G
SUdfVUVWRU5UX0hFTFBFUl9QQVRIPSIvc2Jpbi9ob3RwbHVnIgpDT05GSUdfREVWVE1QRlM9eQpD
T05GSUdfREVWVE1QRlNfTU9VTlQ9eQojIENPTkZJR19TVEFOREFMT05FIGlzIG5vdCBzZXQKQ09O
RklHX0ZXX0xPQURFUl9VU0VSX0hFTFBFUj15CkNPTkZJR19GV19MT0FERVJfVVNFUl9IRUxQRVJf
RkFMTEJBQ0s9eQpDT05GSUdfTVREPXkKQ09ORklHX01URF9DTURMSU5FX1BBUlRTPXkKQ09ORklH
X01URF9CTE9DSz15CkNPTkZJR19NVERfQ0ZJPXkKQ09ORklHX01URF9DRklfSU5URUxFWFQ9eQpD
T05GSUdfTVREX0NGSV9BTURTVEQ9eQpDT05GSUdfTVREX1JBV19OQU5EPXkKQ09ORklHX01URF9O
QU5EX0ZTTF9JRkM9eQpDT05GSUdfTVREX1NQSV9OT1I9eQpDT05GSUdfTVREX1VCST15CkNPTkZJ
R19NVERfVUJJX0ZBU1RNQVA9eQpDT05GSUdfTVREX1VCSV9CTE9DSz15CkNPTkZJR19CTEtfREVW
X0xPT1A9eQpDT05GSUdfQkxLX0RFVl9MT09QX01JTl9DT1VOVD0xCkNPTkZJR19CTEtfREVWX1JB
TT15CkNPTkZJR19CTEtfREVWX1JBTV9DT1VOVD0yCkNPTkZJR19CTEtfREVWX1JBTV9TSVpFPTEz
MTA3MgpDT05GSUdfRUVQUk9NX0FUMjQ9eQpDT05GSUdfRUVQUk9NX0FUMjU9eQpDT05GSUdfRUVQ
Uk9NXzkzQ1g2PW0KQ09ORklHX1NDU0k9eQojIENPTkZJR19TQ1NJX1BST0NfRlMgaXMgbm90IHNl
dApDT05GSUdfQkxLX0RFVl9TRD15CiMgQ09ORklHX1NDU0lfTE9XTEVWRUwgaXMgbm90IHNldApD
T05GSUdfSU5QVVRfRVZERVY9eQojIENPTkZJR19LRVlCT0FSRF9BVEtCRCBpcyBub3Qgc2V0CkNP
TkZJR19LRVlCT0FSRF9HUElPPXkKIyBDT05GSUdfSU5QVVRfTU9VU0UgaXMgbm90IHNldAojIENP
TkZJR19TRVJJTyBpcyBub3Qgc2V0CkNPTkZJR19MRUdBQ1lfUFRZX0NPVU5UPTY0CkNPTkZJR19E
RVZLTUVNPXkKQ09ORklHX1NFUklBTF84MjUwPXkKQ09ORklHX1NFUklBTF84MjUwX0NPTlNPTEU9
eQpDT05GSUdfU0VSSUFMXzgyNTBfTlJfVUFSVFM9MgpDT05GSUdfU0VSSUFMXzgyNTBfUlVOVElN
RV9VQVJUUz0yCkNPTkZJR19TRVJJQUxfODI1MF9NQU5ZX1BPUlRTPXkKQ09ORklHX1NFUklBTF84
MjUwX0RFVEVDVF9JUlE9eQpDT05GSUdfU0VSSUFMXzgyNTBfUlNBPXkKIyBDT05GSUdfTlZSQU0g
aXMgbm90IHNldApDT05GSUdfVENHX1RQTT15CkNPTkZJR19UQ0dfVElTX1NQST15CkNPTkZJR19J
MkM9eQpDT05GSUdfSTJDX0NIQVJERVY9eQpDT05GSUdfSTJDX01QQz15CkNPTkZJR19TUEk9eQpD
T05GSUdfU1BJX0ZTTF9FU1BJPXkKQ09ORklHX0dQSU9MSUI9eQpDT05GSUdfR1BJT19TWVNGUz15
CkNPTkZJR19HUElPX01QQzhYWFg9eQpDT05GSUdfR1BJT19QQ0E5NTNYPXkKQ09ORklHX0dQSU9f
UENBOTUzWF9JUlE9eQojIENPTkZJR19IV01PTiBpcyBub3Qgc2V0CkNPTkZJR19XQVRDSERPRz15
CkNPTkZJR19XQVRDSERPR19OT1dBWU9VVD15CkNPTkZJR19CT09LRV9XRFQ9eQpDT05GSUdfQk9P
S0VfV0RUX0RFRkFVTFRfVElNRU9VVD0zNAojIENPTkZJR19WR0FfQ09OU09MRSBpcyBub3Qgc2V0
CiMgQ09ORklHX0hJRCBpcyBub3Qgc2V0CiMgQ09ORklHX1VTQl9TVVBQT1JUIGlzIG5vdCBzZXQK
Q09ORklHX1JUQ19EUlZfRFMxMzA3PXkKQ09ORklHX1JUQ19EUlZfQ01PUz15CiMgQ09ORklHX0RO
T1RJRlkgaXMgbm90IHNldApDT05GSUdfUFJPQ19LQ09SRT15CkNPTkZJR19UTVBGUz15CkNPTkZJ
R19DT05GSUdGU19GUz15CkNPTkZJR19KRkZTMl9GUz15CkNPTkZJR19KRkZTMl9GU19XQlVGX1ZF
UklGWT15CkNPTkZJR19KRkZTMl9TVU1NQVJZPXkKQ09ORklHX0pGRlMyX0ZTX1hBVFRSPXkKQ09O
RklHX1VCSUZTX0ZTPXkKQ09ORklHX1NRVUFTSEZTPXkKQ09ORklHX1NRVUFTSEZTX0ZJTEVfRElS
RUNUPXkKQ09ORklHX1NRVUFTSEZTX1hBVFRSPXkKQ09ORklHX1NRVUFTSEZTX0xaND15CkNPTkZJ
R19TUVVBU0hGU19MWk89eQpDT05GSUdfU1FVQVNIRlNfWFo9eQpDT05GSUdfU1FVQVNIRlNfNEtf
REVWQkxLX1NJWkU9eQpDT05GSUdfS0VZUz15CkNPTkZJR19DUllQVE9fRUNESD15CkNPTkZJR19D
UllQVE9fQ0NNPXkKQ09ORklHX0NSWVBUT19HQ009eQpDT05GSUdfQ1JZUFRPX0VDSEFJTklWPW0K
Q09ORklHX0NSWVBUT19DQkM9eQpDT05GSUdfQ1JZUFRPX0NUUz15CkNPTkZJR19DUllQVE9fWFRT
PXkKQ09ORklHX0NSWVBUT19FU1NJVj15CkNPTkZJR19DUllQVE9fQ01BQz15CkNPTkZJR19DUllQ
VE9fTUQ1PXkKQ09ORklHX0NSWVBUT19NRDVfUFBDPXkKQ09ORklHX0NSWVBUT19NSUNIQUVMX01J
Qz1tCkNPTkZJR19DUllQVE9fU0hBMT15CkNPTkZJR19DUllQVE9fU0hBMV9QUENfU1BFPXkKQ09O
RklHX0NSWVBUT19TSEEyNTZfUFBDX1NQRT15CkNPTkZJR19DUllQVE9fU0hBNTEyPXkKQ09ORklH
X0NSWVBUT19BRVM9eQpDT05GSUdfQ1JZUFRPX0FFU19QUENfU1BFPXkKQ09ORklHX0NSWVBUT19B
UkM0PXkKQ09ORklHX0NSWVBUT19ERVM9eQpDT05GSUdfQ1JZUFRPX0RFVl9GU0xfQ0FBTT15CkNP
TkZJR19BU1lNTUVUUklDX0tFWV9UWVBFPXkKQ09ORklHX0FTWU1NRVRSSUNfUFVCTElDX0tFWV9T
VUJUWVBFPXkKQ09ORklHX1g1MDlfQ0VSVElGSUNBVEVfUEFSU0VSPXkKQ09ORklHX1BLQ1M3X01F
U1NBR0VfUEFSU0VSPXkKQ09ORklHX1NZU1RFTV9UUlVTVEVEX0tFWVJJTkc9eQpDT05GSUdfQ1JD
X0NDSVRUPW0KQ09ORklHX0NSQ19JVFVfVD1tCkNPTkZJR19DUkM3PW0KQ09ORklHX0xJQkNSQzMy
Qz15CiMgQ09ORklHX1haX0RFQ19YODYgaXMgbm90IHNldAojIENPTkZJR19YWl9ERUNfSUE2NCBp
cyBub3Qgc2V0CiMgQ09ORklHX1haX0RFQ19BUk0gaXMgbm90IHNldAojIENPTkZJR19YWl9ERUNf
QVJNVEhVTUIgaXMgbm90IHNldAojIENPTkZJR19YWl9ERUNfU1BBUkMgaXMgbm90IHNldApDT05G
SUdfRFlOQU1JQ19ERUJVRz15CkNPTkZJR19TVFJJUF9BU01fU1lNUz15CkNPTkZJR19ERUJVR19Q
QUdFQUxMT0M9eQpDT05GSUdfREVCVUdfUEFHRUFMTE9DX0VOQUJMRV9ERUZBVUxUPXkKQ09ORklH
X1BBR0VfUE9JU09OSU5HPXkKQ09ORklHX0RFQlVHX09CSkVDVFM9eQpDT05GSUdfREVCVUdfT0JK
RUNUU19GUkVFPXkKQ09ORklHX0RFQlVHX09CSkVDVFNfVElNRVJTPXkKQ09ORklHX0RFQlVHX09C
SkVDVFNfV09SSz15CkNPTkZJR19ERUJVR19PQkpFQ1RTX1JDVV9IRUFEPXkKQ09ORklHX0RFQlVH
X09CSkVDVFNfUEVSQ1BVX0NPVU5URVI9eQpDT05GSUdfREVCVUdfS01FTUxFQUs9eQpDT05GSUdf
REVCVUdfVk09eQpDT05GSUdfREVCVUdfVk1fVk1BQ0FDSEU9eQpDT05GSUdfREVCVUdfVk1fUkI9
eQpDT05GSUdfREVCVUdfVk1fUEdGTEFHUz15CkNPTkZJR19ERUJVR19WTV9QT0lTT049eQpDT05G
SUdfREVCVUdfVklSVFVBTD15CkNPTkZJR19ERUJVR19NRU1PUllfSU5JVD15CkNPTkZJR19ERUJV
R19TVEFDS09WRVJGTE9XPXkKQ09ORklHX0tBU0FOPXkKQ09ORklHX0RFVEVDVF9IVU5HX1RBU0s9
eQpDT05GSUdfREVGQVVMVF9IVU5HX1RBU0tfVElNRU9VVD02MApDT05GSUdfQk9PVFBBUkFNX0hV
TkdfVEFTS19QQU5JQz15CiMgQ09ORklHX1NDSEVEX0RFQlVHIGlzIG5vdCBzZXQKQ09ORklHX1ND
SEVEX1NUQUNLX0VORF9DSEVDSz15CiMgQ09ORklHX0RFQlVHX1BSRUVNUFQgaXMgbm90IHNldAoj
IENPTkZJR19ERUJVR19CVUdWRVJCT1NFIGlzIG5vdCBzZXQKQ09ORklHX1JDVV9FUVNfREVCVUc9
eQpDT05GSUdfRlVOQ1RJT05fVFJBQ0VSPXkKQ09ORklHX0JVR19PTl9EQVRBX0NPUlJVUFRJT049
eQpDT05GSUdfVUJTQU49eQpDT05GSUdfUFBDX0RJU0FCTEVfV0VSUk9SPXkKQ09ORklHX1BQQ19F
TVVMQVRFRF9TVEFUUz15CkNPTkZJR19QUENfSVJRX1NPRlRfTUFTS19ERUJVRz15CkNPTkZJR19C
RElfU1dJVENIPXkK
--000000000000bd340605a6ce1984--
