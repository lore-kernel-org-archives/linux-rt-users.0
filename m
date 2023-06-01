Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FA1C7EE23
	for <linux-rt-users@archiver.kernel.org>; Thu,  1 Jun 2023 20:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjFAU2a (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjFAU23 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 1 Jun 2023 16:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E44107
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 13:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685651262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=aCk3IYjkpgLYYETMxJaZ9PH7m6kwzN5mLtF+XfE1zWY=;
        b=NPh2g4JJCKP6Kt7ENhHh2id9zqBdNDx21n39soX9FQj0/1buKlY8sSRqaOl9XUiqztnoWy
        waqs/6T5N7CACD6kcZKLWscB38Kcwykq+bMMkItUjinU/muEQtqOkv6HuNiBeoVcps5n/U
        8ZU13+UP/T6mHEOtL/PSDKPJvppVqsw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-h-ITKYmrM92J_Gn1NSvgLg-1; Thu, 01 Jun 2023 16:27:41 -0400
X-MC-Unique: h-ITKYmrM92J_Gn1NSvgLg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 56E4D101A585
        for <linux-rt-users@vger.kernel.org>; Thu,  1 Jun 2023 20:27:41 +0000 (UTC)
Received: from ashelat.remote.csb (unknown [10.22.34.121])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 305D0C154DA;
        Thu,  1 Jun 2023 20:27:41 +0000 (UTC)
From:   Anubhav Shelat <ashelat@redhat.com>
To:     linux-rt-users@vger.kernel.org
Cc:     Anubhav Shelat <ashelat@redhat.com>
Subject: [PATCH v2 00/10] Cover Letter
Date:   Thu,  1 Jun 2023 16:27:25 -0400
Message-Id: <20230601202734.813515-1-ashelat@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Patch 9 fixes an issue where the device has IPv6 disabled, causing a FileNotFound error. 

All other patches edit files to replace standard strings with f-strings.

Anubhav Shelat (10):
  rteval: Use f-strings in rtevalclient.py
  rteval: Use f-strings in rtevalConfig
  rteval: Use f-strings in cputopology
  rteval: Use f-strings in kernel.py
  rteval: Use f-strings in memory.py
  rteval: Use f-strings in osinfo
  rteval: Use f-strings in services.py
  rteval: Use f-strings in tools.py
  Added code to check if the proc/net/if_inet6 file exists while loading
    IPv6 addresses in the IPv6Addresses class
  rteval: Use f-strings in __init__.py

 rteval/rtevalConfig.py        |  2 +-
 rteval/rtevalclient.py        |  2 +-
 rteval/sysinfo/__init__.py    | 18 +++++++-----------
 rteval/sysinfo/cputopology.py |  4 +---
 rteval/sysinfo/kernel.py      |  4 ++--
 rteval/sysinfo/memory.py      |  8 ++++----
 rteval/sysinfo/newnet.py      | 28 ++++++++++++++++------------
 rteval/sysinfo/osinfo.py      | 12 ++++++------
 rteval/sysinfo/services.py    | 12 ++++++------
 rteval/sysinfo/tools.py       |  2 +-
 10 files changed, 45 insertions(+), 47 deletions(-)

-- 
2.31.1

