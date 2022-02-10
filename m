Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2DEC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu, 10 Feb 2022 08:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbiBJIer (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 10 Feb 2022 03:34:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiBJIeo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 10 Feb 2022 03:34:44 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF33E4F
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 00:34:45 -0800 (PST)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6299F4005D
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1644482084;
        bh=pGebfukMA0/cVNt1ZjmZH/7cNrKPzwQS8ExlqEeW/aA=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=lwnSlTzfmpcEx9Wh36NnaX5DTSjRKDDTSBLIpAHIIGq4aCPoLHqmzXK6fq9x2w87B
         ceH1NQTB/RzDnb5QxFV/xbjqiS9gsYRLZyv0OaPDd3x5+n7xqatCyAn2GmSwJiTDnU
         5sIaexIyYDdk44tcpi5fzaJWSRb98SYa8fTpz8V1KfpQDSogkxaNJ11jH+7nc3MKmC
         18ySKAXkD2VxDsxV+arS2Ygom7EljaUB9kNtpi/lFfhUlbb++urf1NCcRCEnuZBf2v
         nPSiddECJuJSGzPZP9lglkqY33oc3hXYuEtnRDNb/58/lMK0ugOYEMBQ/pMy/Ox4kY
         cQBR2KfUZJrPg==
Received: by mail-ej1-f70.google.com with SMTP id ky6-20020a170907778600b0068e4bd99fd1so2359120ejc.15
        for <linux-rt-users@vger.kernel.org>; Thu, 10 Feb 2022 00:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGebfukMA0/cVNt1ZjmZH/7cNrKPzwQS8ExlqEeW/aA=;
        b=IWr4K7GuntUGlt1zS+jCdAbuNOsmNyUBhYIacJJaGXU9YTciVO5/sMBZsw7RJ3H/Bu
         DWr9tF9CQsgHzXXir7EArMUEmZjrW76QZHpMOI4Bo+UCSeCfNCj1bvOOKX4Oo626j5WN
         23uZmwPsU5CSu8r22s7i6+N5IEESTj7EpvmQc1//uakW/TZsmttNfrAktYBVBfHlY5GL
         aBrYlFx15a3fpT/Z9wLPXTXJTfxMSYp3o4RcETQnbFEn1/+kxHF//KEUlWLXD3ln3jLG
         KPoLZWMkNlyxXb9anwB/rCb6md9XW5UhgSGopaOaLJECvNsl6Nmky2f8fFsTIoIj57fI
         YbIQ==
X-Gm-Message-State: AOAM531a4fTirnKimk/dmAub+kaG5B02o0LQvzq78eljHSlkpxsD77Cg
        yVuLGUc821bWDBzKe53/sn0HFQrSPEWkqXtwB2es9UwbPdJ2QOavS8a2ufGjLF4e5Q9oQlBsok3
        qR1XsaqC5Pn8zv6JFl9bkyECkMhn949VBjaRezw5AABMA
X-Received: by 2002:a17:906:648a:: with SMTP id e10mr5362011ejm.608.1644482083889;
        Thu, 10 Feb 2022 00:34:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxi63reSP6zKskv4B7VSWKJyO4DkjBtRkrM6w8hTZY1HnS05jKb54fS63VtY8oyNWSo8tLgdA==
X-Received: by 2002:a17:906:648a:: with SMTP id e10mr5362002ejm.608.1644482083651;
        Thu, 10 Feb 2022 00:34:43 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id r22sm9289438edt.51.2022.02.10.00.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 00:34:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org, joseph.salisbury@canonical.com
Cc:     Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2] selftests/ftrace: Do not trace do_softirq because of PREEMPT_RT
Date:   Thu, 10 Feb 2022 09:33:56 +0100
Message-Id: <20220210083356.11212-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The PREEMPT_RT patchset does not use soft IRQs thus trying to filter for
do_softirq fails for such kernel:

  echo do_softirq
  ftracetest: 81: echo: echo: I/O error

Choose some other visible function for the test.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

---

Changes since v1:
1. Use scheduler_tick.
2. Add review tag.

Notes:
I understand that the failure does not exist on mainline kernel (only
with PREEMPT_RT patchset) but the change does not harm it.

If it is not suitable alone, please consider it for RT patchset.
---
 .../selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
index e96e279e0533..25432b8cd5bd 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_set_ftrace_file.tc
@@ -19,7 +19,7 @@ fail() { # mesg
 
 FILTER=set_ftrace_filter
 FUNC1="schedule"
-FUNC2="do_softirq"
+FUNC2="scheduler_tick"
 
 ALL_FUNCS="#### all functions enabled ####"
 
-- 
2.32.0

