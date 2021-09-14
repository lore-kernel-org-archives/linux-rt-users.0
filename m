Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59012C433EF
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDCF610E6
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Sep 2021 13:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhINNoV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 09:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41246 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233379AbhINNoO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Sep 2021 09:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631626976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=jewliOMoymG5rXVJn02fxoFBXvIvVLdk8M/V9Z5usRQ=;
        b=CvO8aVNoAWJ48O+56moTWpk+1zJ+8IuByFPOU6Oyd3CWSW0d2abHDr2wfzdITeYDSe/dga
        a6nM49eYFvlkdKPnK5HamBlv/oh/S/NIBrGVz8VUTwrfgM2WRsMr8wq7XdqUjZLjqmHLfd
        9267ghif9PZ1XvdGYqMB+i2Su0CmsK4=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-Cr7Ko2ZgP_KPSe4qna5GZQ-1; Tue, 14 Sep 2021 09:42:56 -0400
X-MC-Unique: Cr7Ko2ZgP_KPSe4qna5GZQ-1
Received: by mail-oi1-f199.google.com with SMTP id 20-20020aca2814000000b002690d9b60aaso8622726oix.0
        for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2021 06:42:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=jewliOMoymG5rXVJn02fxoFBXvIvVLdk8M/V9Z5usRQ=;
        b=29zdAxH6xf33OZPQSUb/bCDYs5tQRCKKZWrrCQhNM4KRTK21w0RfwzYgG7CxTXtke1
         gClbSqaxHQYoyPFrWHgqzNDSEU07Tk7O9ChG84dHMW+Rlws2tt4hTYcPB3nl7CC5uAc6
         Uzahqn3LDk1CW5AaFWhw1A//hQ1WOLdekECJ11Cs2Y7TcON8L2ZqITU7m3FvJaNeDB8Y
         nUUVQqLC/h39wpejUGgYNCeO6R34XewnyXhekFrmAoMAIOF2GNLTTHEb5XWq4QZwyPhL
         UBVP9XhpyoyTkqk/WjtaD0V+3YpG+mCa1ZICKb93su1g3ZAs1svoLiZ1GEEchqk3mT5o
         uQPw==
X-Gm-Message-State: AOAM532+35a5Y7lLDhGkrgBPWK5acYTnE5MrCF283KQ9RvA0Lmp3zXSH
        ZKGQ6D0xRkA3QEztGOFxCeDs6y0GL0U0SMFhzpXH8mZpKRSSR4CaZBgiWdGJrAwSBcRSkFqhmYG
        SHcMfcKPNE5pZ//sNzUPhfjrgFI8ScZ42h8etfXdWo5g=
X-Received: by 2002:a4a:b502:: with SMTP id r2mr14102828ooo.70.1631626974984;
        Tue, 14 Sep 2021 06:42:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzMIQUlfxqrsC+2bS/iQPITAGVoQjPry2ufHDYgLSd+g2eZ2C36iW//5CotpIeKeoLhwhrTU8SDK9jFyxL97+I=
X-Received: by 2002:a4a:b502:: with SMTP id r2mr14102813ooo.70.1631626974754;
 Tue, 14 Sep 2021 06:42:54 -0700 (PDT)
MIME-Version: 1.0
From:   Bruno Goncalves <bgoncalv@redhat.com>
Date:   Tue, 14 Sep 2021 15:42:43 +0200
Message-ID: <CA+QYu4rSCmGt8Do8_qbi1fyHA8CyuL-vhzTfTKfHVOpyVjYH0A@mail.gmail.com>
Subject: kernel-rt: BUG: sleeping function called from invalid context at mm/vmalloc.c:2664
To:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     CKI Project <cki-project@redhat.com>,
        Xiong Zhou <xzhou@redhat.com>,
        Memory Management <mm-qe@redhat.com>,
        Juri Lelli <jlelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,

When testing commit "8a084036f2bc - v5.14.2-rt21" from
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git
during "cifsv3.11" test part of xfstests [1] we hit the following
issue:

[13099.772703] BUG: sleeping function called from invalid context at
mm/vmalloc.c:2664
[13099.772709] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
613586, name: cifsd
[13099.772712] 1 lock held by cifsd/613586:
[13099.772715]  #0: ffffffffc0eb76d8 (&GlobalMid_Lock){+.+.}-{2:2},
at: cifs_mid_q_entry_release+0x15/0x110 [cifs]
[13099.772816] CPU: 7 PID: 613586 Comm: cifsd Not tainted 5.14.2-rt21 #1
[13099.772820] Hardware name: AMD Pike/Pike, BIOS RPK1506A 09/03/2014
[13099.772822] Call Trace:
[13099.772828]  dump_stack_lvl+0x57/0x72
[13099.772838]  ___might_sleep.cold+0xb6/0xc6
[13099.772845]  vfree+0x3f/0x50
[13099.772852]  put_task_stack+0xcf/0x140
[13099.772858]  __put_task_struct+0x46/0x180
[13099.772862]  cifs_mid_q_entry_release+0xce/0x110 [cifs]
[13099.772944]  cifs_demultiplex_thread+0x797/0xcb0 [cifs]
[13099.773031]  ? mutex_is_locked+0x1/0x20
[13099.773042]  ? _raw_spin_unlock_irqrestore+0x37/0x40
[13099.773050]  ? cifs_handle_standard+0x190/0x190 [cifs]
[13099.773121]  kthread+0x15c/0x180
[13099.773126]  ? set_kthread_struct+0x40/0x40
[13099.773134]  ret_from_fork+0x22/0x30


So far we've hit this problem just once, more logs can be found at [2].


[1] https://gitlab.com/cki-project/kernel-tests/-/tree/main/filesystems/xfs/xfstests
[2] https://arr-cki-prod-datawarehouse-public.s3.amazonaws.com/index.html?prefix=datawarehouse-public/2021/09/13/369543188/build_x86_64_redhat%3A1584042034/tests/xfstests_cifsv3_11/

Thank you,
Bruno

