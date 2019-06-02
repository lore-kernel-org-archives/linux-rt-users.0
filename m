Return-Path: <SRS0=u+k8=UB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472C1C282DC
	for <linux-rt-users@archiver.kernel.org>; Sun,  2 Jun 2019 08:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1242F27895
	for <linux-rt-users@archiver.kernel.org>; Sun,  2 Jun 2019 08:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmBKQ4wj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfFBImO (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 2 Jun 2019 04:42:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46655 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfFBImO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 2 Jun 2019 04:42:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id l26so11176765lfh.13
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Jun 2019 01:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3zCTP+2kNgPtEHjF8wGLo1qwIHsCPgZXmiBKmW0MVI8=;
        b=MmBKQ4wjsm9QWSjKkDrqwxkIf2v8U8fWByKo10G5alu7c1UtOoJi5S8Vv4od2ZDvLN
         863oFylHf0rcE2nU4fQIu8pYnLN8gD1c0EorrQCrSiY/37856raBSwRD7fgDimMdwcke
         ZxAw5+18eh81mIh4hl9MrYR2RWjigK/yNwki4PXBKmrSNA/jk91YnDxP7P7grbdGI35o
         VaNKaRTZN8xjuLEWOyUx0ylX2lcZTVsP135W8fS1aANJGV94+capnvHCH+AsIjDOd5Gr
         hA3ce7WjoKQ3VWLjLmQD/npOQI4zUB/040fwkDovYJj1hwoXxTfq5hVyUW+IgamIJ7Hk
         CNNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3zCTP+2kNgPtEHjF8wGLo1qwIHsCPgZXmiBKmW0MVI8=;
        b=rlO6PYhTOQPso+p1Ok4YwuTAo78pTeLEITNJW9mHXP3qN1pJNXrXOvbcxfIksfiUcc
         /rfwcEZGrNCzCl3dQzq3Fgc0KTXC9dVrPRN9VXYeexou2oZmfugoomxgbC6YtfGxijjt
         T1vYybbQpCpgT3OwmDaND9zfhxhesUE3aWtU2rXmgM6n69NySWm3ROUs9DDz4XmDYRd6
         ZK1O8icRPro+E+/jUR8GtX2PVRZ8K9V+ZUQ4EVSAAMyUhxjF3JNu0Ock6+rMGqKTbduc
         UQLu7MS+N4H4r4EOVzNSb3ZemSWc0NJ0rSI/r0HUS8zAZO79E7uYK4s8Uuvsy+zu27Nr
         YEwg==
X-Gm-Message-State: APjAAAWJsb682day0wlj2NO0DoG7pHFcnbv6LvdvDfPmXu1JQhXo4bl7
        8oCtX6GhxUhq2IzxApzkPvRPU6HOEoJEX+KLAbUQmEbDOFBdMVTrucQ=
X-Google-Smtp-Source: APXvYqy/EW+UiXGzVlpo8BB/1lNwe7pVn6FluEpt5SibqtF1HfzBOLF/0L2o2Mx/HRyO5mN1EhacdvxTtDIMVM4W/pg=
X-Received: by 2002:a19:6a07:: with SMTP id u7mr6590831lfu.74.1559464932882;
 Sun, 02 Jun 2019 01:42:12 -0700 (PDT)
MIME-Version: 1.0
From:   Itai Handler <itai.handler@gmail.com>
Date:   Sun, 2 Jun 2019 11:42:02 +0300
Message-ID: <CAFpOueS0hVFbx5PJm=ofMJTxPmE-k3s3zJ5sP05akqtQw_vHFw@mail.gmail.com>
Subject: igh latency when writing to files - 4.14-rt1
To:     linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I observed higher that usual latencies when running:
$ cd /tmp
$ taskset 2 stress -d 1 --hdd-bytes 1M &
$ timeout 5 taskset 8 cyclictest -p80 -i250 -n -q

The maximum latency is 43:
T: 0 (3060) P:80 I:250 C: 39980 Min:   6 Act:  15 Avg:   9 Max:  43

When running stress -m, the maximum latency was about 18, which is
much smaller than 43.

The system is arm64 (Xilinx ZCU102 board) with linux kernel 4.14-rt1.

stress -d performs file writes and calls unlink().

I am curious why the maximum latency is more than doubled with stress -d
and I wonder if there is any way to improve it.

Note that I traced the exectution using ftrace and saw the following call stack:

raw_spin_lock_irqsave
task_rq_lock
migrate_disable_update_cpus_allowed
migrate_disable
pagefault_disable
kmap_atomic
iov_iter_copy_from_user_atomic
generic_perform_write
__generic_file_write_iter
__vfs_write

I guess that raw_spin_lock_irqsave disables interrupts, but I'm not
sure if this is
the cause of the high latency.
ftrace says that migrate_disable takes about 20 microseconds
and migrate_enable another 20 microseconds, but ftrace itself has some overhead.
