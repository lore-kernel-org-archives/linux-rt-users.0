Return-Path: <SRS0=PGN5=5R=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C6DC43331
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F212078C
	for <linux-rt-users@archiver.kernel.org>; Wed,  1 Apr 2020 15:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MO5I1n8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733161AbgDAPGa (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:06:30 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53132 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732551AbgDAPGa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 1 Apr 2020 11:06:30 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 031F6IrT103459;
        Wed, 1 Apr 2020 10:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585753578;
        bh=rpGOkl7+au8ZR5Xc81hv83OdjAR+iCGu/F9rpYgq2M4=;
        h=To:CC:From:Subject:Date;
        b=MO5I1n8IQO/HQNfC4Nc/PKY9H5Jw5OetvV5ztUszr20sJ9ooYGOAQRz/O1n7w78Hx
         6XmVOed0vtael3AH6JtsVOLddUaUNr4nLqVT+ravD8aZ1Iz6UXb9jl9vsu1mVj1cXH
         3a02A+9Pk2c0tFABqwjQNMlmP8B1ocsrhNUZyblQ=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 031F6Isx103822;
        Wed, 1 Apr 2020 10:06:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 1 Apr
 2020 10:06:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 1 Apr 2020 10:06:18 -0500
Received: from [10.250.100.73] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 031F6Fc5125236;
        Wed, 1 Apr 2020 10:06:16 -0500
To:     <linux-rt-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Nori, Sekhar" <nsekhar@ti.com>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [v5.4.28-rt19] ARM64: nfs boot issues
Message-ID: <0d05e716-5575-d4bd-64be-187c85244c12@ti.com>
Date:   Wed, 1 Apr 2020 18:06:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi All,

We now observe NFS boot issues with TI RT Kernel (last merged tag v5.4.28-rt19) on TI (ARM64) AM654x/J721E platforms.
It's just stack (100%) silently right after Kernel init (log1) or in the middle of the boot (log2).

I'm trying to investigate an issue and I'd like to ask if anybody else observed the same?

Few notes:
- I can not test clear rt-devel/linux-5.4.y-rt as above TI platform not fully supported there
- ARM32 platforms not affected
- Disabling CONFIG_PREEMPT_RT=n with CONFIG_PREEMPT=y makes NFS boot work again
- non RT Kernel has no issues

NFS configuration:
  rw rootfstype=nfs root=/dev/nfs rw nfsroot=192.168.0.110:/mnt/am65xx-evm,nolock,v3,tcp,rsize=4096,wsize=4096 ip=dhcp

===== Log1:
[   13.423029] 000: am65-cpsw-nuss 46000000.ethernet eth0: Link is Up - 100Mbps/Full - flow control off
[   13.449187] 003: Sending DHCP requests .
[   13.457269] 002: ,
[   13.965284] 001:  OK
[   13.965769] 001: IP-Config: Got DHCP answer from 192.168.0.1, my address is 192.168.0.105
[   13.965788] 001: IP-Config: Complete:
[   13.965794] 001:      device=eth0, hwaddr=f4:84:4c:eb:a0:00, ipaddr=192.168.0.105, mask=255.255.255.0, gw=192.168.0.1
[   13.965804] 001:      host=192.168.0.105, domain=, nis-domain=(none)
[   13.965814] 001:      bootserver=0.0.0.0, rootserver=192.168.0.110, rootpath=
[   13.965821] 001:      nameserver0=192.168.0.1, nameserver1=0.0.0.0
[   13.999107] 001: ALSA device list:
[   13.999725] 001:   No soundcards found.
[   14.121815] 001: VFS: Mounted root (nfs filesystem) on device 0:21.
[   14.126072] 001: devtmpfs: mounted
[   14.139110] 001: Freeing unused kernel memory: 2688K
[   14.150126] 000: Run /sbin/init as init process
[  195.694278] 002: nfs: server 192.168.0.110 not responding, still trying
[  195.694314] 003: nfs: server 192.168.0.110 not responding, still trying
[  195.694875] 000: nfs: server 192.168.0.110 not responding, still trying
[  195.694921] 003: nfs: server 192.168.0.110 not responding, still trying
^^^

===== Log2:
[  OK  ] Stopped Network Time Synchronization.
          Starting Network Time Synchronization...
[  OK  ] Found device /dev/ttyS2.
[  OK  ] Started Network Service.
[FAILED] Failed to start Network Time Synchronization.
See 'systemctl status systemd-timesyncd.service' for details.
[   97.141595] 000: sysrq: This sysrq operation is disabled.
[  191.511935] 001: nfs: server 192.168.0.110 not responding, still trying
[  191.511995] 003: nfs: server 192.168.0.110 not responding, still trying
[  191.512001] 002: nfs: server 192.168.0.110 not responding, still trying
   
^^^

-- 
Best regards,
grygorii
