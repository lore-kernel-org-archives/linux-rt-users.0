Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E33C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  6 Apr 2022 20:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbiDFUG5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 16:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiDFUGL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Apr 2022 16:06:11 -0400
Received: from mail194c50.megamailservers.eu (mail213c50.megamailservers.eu [91.136.10.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B45203A40
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Apr 2022 10:53:45 -0700 (PDT)
X-Authenticated-User: ralf.mardorf@o2mail.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megamailservers.eu;
        s=maildub; t=1646853334;
        bh=8gRtmVN28drM65ksClWqdsaDmyz+2PYCk3GP1LVCPZI=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=NvNvrDxNwrm0R7gkp51fZafCD2hPWelgJHYcpBCazlXtgLWr4LVMTTYkrVYWWCO8w
         szlTquYW4L4usk4/TxJ5jkEv/HL3+IEwDT8AzZyJQmSqpk1k9bAXGR+cvXpUqHbX+y
         bkPGEqi6gLUP+BwWr6Wpsr/zim+YvtlcBhJdXAco=
Feedback-ID: ralf.mardorf@al
Received: from archlinux (dynamic-078-048-006-193.78.48.pool.telefonica.de [78.48.6.193])
        (authenticated bits=0)
        by mail194c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id 229JFWFL007272
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Wed, 9 Mar 2022 19:15:33 +0000
Date:   Wed, 9 Mar 2022 20:15:34 +0100
From:   Ralf Mardorf <ralf.mardorf@alice-dsl.net>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: dirty-pipe ?
Message-ID: <20220309201534.3a3b8e22@archlinux>
In-Reply-To: <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
References: <2658635.4HAHC1xCac@coyote>
        <CAJjrzcUo_30mZAuWVN4W2WK=WcoFC_55_Lq5y7YxdjD37US_YA@mail.gmail.com>
X-Mailer: Claws Mail (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CTCH-RefID: str=0001.0A742F1C.6228FCD5.0094,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-Score: 0.000
X-CTCH-Rules: 
X-CTCH-Flags: 0
X-CTCH-ScoreCust: 0.000
X-Origin-Country: DE
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 9 Mar 2022 19:22:15 +0100, Arve Barsnes wrote:
>On Wed, 9 Mar 2022 at 19:16, gene heskett <gheskett@shentel.net> wrote:
>> Is this kernel vulnerable?
>> 4.19.71-rt24-v7l+ #1 SMP PREEMPT RT Thu Feb 6 07:09:18 EST 2020
>> armv7l GNU/Linux  
>
>No, the vulnerability was introduced in kernel 5.8

Hi,

that is my understanding, too, hence my reply yesterday on another
mailing list, see
https://lists.ubuntu.com/archives/ubuntu-users/2022-March/307093.html .

However, 4.19 kernels received many patches and I haven't verified
myself that non of those patches includes a backport introducing dirty
pipe or any other nasty issue.

Regards,
Ralf

-- 
[rocketmouse@archlinux ~]$ pacman -Q linux-rt{-cornflower,-pussytoes,,-securityink}|cut -d\  -f2
4.19.230_rt103-0.300
4.19.227_rt102-0.300
4.19.223_rt100-0.1000
4.19.219_rt97-0.300
[rocketmouse@archlinux ~]$ echo $(uname -srvm;zgrep CONFIG_AUDIT\  /proc/config.gz || zgrep CONFIG_AUDIT= /proc/config.gz);echo;cat /proc/cmdline;echo;grep . /sys/devices/system/cpu/vulnerabilities/* | cut -d/ -f7;rtirq status|head -8 
Linux 4.19.230-rt103-0.300-cornflower #1 SMP PREEMPT RT Tue, 22 Feb 2022 07:30:23 +0100 x86_64 # CONFIG_AUDIT is not set

BOOT_IMAGE=../vmlinuz-linux-rt-cornflower root=LABEL=s3.archlinux ro initrd=../intel-ucode.img,../initramfs-linux-rt-cornflower.img

itlb_multihit:KVM: Mitigation: Split huge pages
l1tf:Mitigation: PTE Inversion; VMX: conditional cache flushes, SMT disabled
mds:Mitigation: Clear CPU buffers; SMT disabled
meltdown:Mitigation: PTI
spec_store_bypass:Mitigation: Speculative Store Bypass disabled via prctl and seccomp
spectre_v1:Mitigation: usercopy
spectre_v2:Mitigation: Full generic retpoline, IBPB: conditional, IBRS_FW, STIBP: disabled, RSB filling
srbds:Mitigation: Microcode
tsx_async_abort:Not affected

    PID CLS RTPRIO  NI PRI %CPU STAT COMMAND	
    142 FF      90   - 130  0.0 S    irq/24-xhci_hcd	
    153 FF      90   - 130  0.0 S    irq/16-ehci_hcd	
    156 FF      89   - 129  0.0 S    irq/23-ehci_hcd	
    312 FF      85   - 125  0.0 S    irq/16-snd_hdsp	
    339 FF      80   - 120  0.0 S    irq/16-snd_ice1	
     42 FF      50   -  90  0.0 S    irq/9-acpi
