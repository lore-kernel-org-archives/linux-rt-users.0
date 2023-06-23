Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA276EB64D7
	for <linux-rt-users@archiver.kernel.org>; Fri, 23 Jun 2023 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbjFWRP3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjFWRP1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Jun 2023 13:15:27 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332861731
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 10:15:23 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-76244657caeso78271385a.0
        for <linux-rt-users@vger.kernel.org>; Fri, 23 Jun 2023 10:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sr-research.com; s=google; t=1687540522; x=1690132522;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p8EJZk8Ddip/tfpD/j4Qc6TvxGgfui5VkAjbM20cUpg=;
        b=dZloRJ0HqtwR46TviXbz85CGgYkdaNMvqkgEX+NM9ikgQa/znLbUlwHxEZdnqdwFio
         pS35XndqRHGXbtndTBy9nY5wG7U6dfYXtUEs/5l2XDtOMEZDvd5XQdmy9AIClpoQPlGl
         Rfb16Ng8zHWndfPpW7om3MJuuD2ty9SeWQssI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540522; x=1690132522;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p8EJZk8Ddip/tfpD/j4Qc6TvxGgfui5VkAjbM20cUpg=;
        b=TEsS+Z9H3YbHNhfnINFMEHoOL7oGwEwqqMAMlSSEH5k3FQyAgcraVN+GYKB7j9ClPy
         Yx+7K3AvWR02Y0tOu3nIqwSgJTtLOXCis4ju5Ul4vPak59BayCXXR/TvWhkpRZNcxuYc
         sY71dBxgJ/yTEK6FOvlGiX0wI+tncZQhfuF2FE4KSNbc0RnbP7g/ZQToLg6l4AiAqIxN
         G4T5H4QE+/BjL9eThxqJu47r5rTLka9ah6fZ7WYeNPwkgeIyLTWoS/ejXQXWalJJ2D9Y
         XGpSK4jCOReqP7AkrU4ydNEbkuMqkj8nA92EWm7idFwRBnv9XAIoLfmDFLeM67cXINv0
         c/mA==
X-Gm-Message-State: AC+VfDxJlIhFg3VJ/p1X2PstA20vlgkRkfDR+Y9zydtzWNs3g6r7QCGa
        kZ3Zpjzk4LLuuL3oXhThmqDCUxxy4+C+a6wuCJ8bm4+k6/0UPS6FiEs=
X-Google-Smtp-Source: ACHHUZ6oPb1SArWyNfkQlIUwMu1R5HMne2m3lWPBeNy4o8aYrFYZtw1zxEjw4AX6T8ro8ykPNi7Y7PKCiQgQ7Y30gE0=
X-Received: by 2002:ad4:5769:0:b0:632:10b1:7cf with SMTP id
 r9-20020ad45769000000b0063210b107cfmr9472576qvx.36.1687540522115; Fri, 23 Jun
 2023 10:15:22 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Hicks <martin@sr-research.com>
Date:   Fri, 23 Jun 2023 13:15:11 -0400
Message-ID: <CAMkvodZZKriPgWVwQ7R6ZS9eSbmmE3FC3f35QLg6u40NsnGJpg@mail.gmail.com>
Subject: POSIX timer wakeups not preempting RT threads
To:     linux-rt-users@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005dd48305fecf2595"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

--0000000000005dd48305fecf2595
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm just getting started with RT linux, and am porting an existing
threaded application from another RTOS.

I'm looking at using a POSIX timer to cause an action to be run every
500us, but I'm seeing that when the hrtimer fires while the CPU is
busy running another SCHED_RR/SCHED_FIFO process that the hrtimer is
deferred until the process releases the CPU.  I'm using SIGEV_SIGNAL
to deliver the timer expiry to a thread that's running at a higher RT
Priority than the other tasks, but no preemption seems to occur.

If the "other" tasks are running with SCHED_OTHER then the signal is
delivered immediately.

I've tried using 'cset shield -c 1' and without (just pinning use
taskset -c 1), and modified priorities and scheduler with chrt.
The test is running on x86_64 with 6.3.9-rt15. PREEMPT_RT is enabled.

A simple test that illustrates the idea is attached.
Is this supposed to work?

mh

--0000000000005dd48305fecf2595
Content-Type: text/x-csrc; charset="US-ASCII"; name="test-rt.c"
Content-Disposition: attachment; filename="test-rt.c"
Content-Transfer-Encoding: base64
Content-ID: <f_lj8u0fnq0>
X-Attachment-Id: f_lj8u0fnq0

I2RlZmluZSBfR05VX1NPVVJDRQojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPHB0aHJlYWQu
aD4KI2luY2x1ZGUgPHNpZ25hbC5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDx1bmlz
dGQuaD4KI2luY2x1ZGUgPGVycm5vLmg+CiNpbmNsdWRlIDxmY250bC5oPgojaW5jbHVkZSA8c3Rk
bGliLmg+CiNpbmNsdWRlIDxtYXRoLmg+CgojZGVmaW5lIFRJTUVSX1BSSU9SSVRZIDEwCiNkZWZp
bmUgV09SS0VSX1BSSU9SSVRZIDkKCiNkZWZpbmUgT05FX0tIWiAoMTAwMDAwMEwpCiNkZWZpbmUg
S0haKG4pICBPTkVfS0haL24KCiNkZWZpbmUgV09SS0VSUyAyCnZvbGF0aWxlIGRvdWJsZSB3b3Jr
ZXJfZGF0YVtXT1JLRVJTXTsKCiNkZWZpbmUgV09SS19JTlRFUlZBTCAyMCAgLyogbXMgdG8gd29y
ayBwZXIgc2VjICovCgpkb3VibGUgY3VycmVudF90aW1lX2RvdWJsZSh2b2lkKQp7CiAgICBzdHJ1
Y3QgdGltZXNwZWMgdHM7CgogICAgY2xvY2tfZ2V0dGltZShDTE9DS19NT05PVE9OSUMsICZ0cyk7
CiAgICByZXR1cm4gdHMudHZfc2VjKjFlNiArIHRzLnR2X25zZWMvMTAwMC4wOwp9Cgp2b2lkICp3
b3JrZXJfZnVuYyh2b2lkICphcmcpCnsKICB1bnNpZ25lZCBsb25nIG51bSA9ICh1bnNpZ25lZCBs
b25nKWFyZzsKICBjaGFyIHRocmVhZF9uYW1lWzE2XTsKICBpbnQgaW5pdF9zbGVlcCA9IHJhbmRv
bSgpICUgMTAwMDsKICBpbnQgcmV0OwoKICBzbnByaW50Zih0aHJlYWRfbmFtZSwgMTYsICJ3b3Jr
ZXJfJWxkIiwgbnVtKTsKICBpZiAoKHJldCA9IHB0aHJlYWRfc2V0bmFtZV9ucChwdGhyZWFkX3Nl
bGYoKSwgdGhyZWFkX25hbWUpKSAhPSAwKSB7CiAgICBwcmludGYoIndvcmtlciAlbGQ6IEZhaWxl
ZCBzZXRuYW1lOiAlc1xuIiwgbnVtLCBzdHJlcnJvcihyZXQpKTsKICAgIHJldHVybiBOVUxMOwog
IH0KCiAgc3RydWN0IHNjaGVkX3BhcmFtIHBhcmFtID0gey5zY2hlZF9wcmlvcml0eSA9IFdPUktF
Ul9QUklPUklUWX07CiAgaWYgKHNjaGVkX3NldHNjaGVkdWxlcigwLCBTQ0hFRF9SUiwgJnBhcmFt
KSA9PSAtMSkgewogICAgcHJpbnRmKCJ3b3JrZXIgJWxkOiBGYWlsZWQgc2NoZWRfc2V0c2NoZWR1
bGVyKCk6ICVzXG4iLCBudW0sIHN0cmVycm9yKGVycm5vKSk7CiAgICByZXR1cm4gTlVMTDsKICB9
CgogIHdvcmtlcl9kYXRhW251bV0gPSBpbml0X3NsZWVwOwogIHByaW50ZigiV29ya2VyICVsZCBz
dGFydGVkLiBJbml0IHNsZWVwICVkXG4iLCBudW0sIGluaXRfc2xlZXApOwogIHVzbGVlcChpbml0
X3NsZWVwKjEwMDApOwoKICBmb3IgKDs7KSB7CiAgICBkb3VibGUgd29ya19zdGFydCA9IGN1cnJl
bnRfdGltZV9kb3VibGUoKTsKICAgIGludCBpOwoKICAgIGRvIHsKICAgICAgZm9yIChpID0gMDsg
aSA8IDEwMDAwMDsgaSsrKQogICAgICAgIHdvcmtlcl9kYXRhW251bV0gKj0gTV9QSTsKICAgIH0g
d2hpbGUgKGN1cnJlbnRfdGltZV9kb3VibGUoKSAtIHdvcmtfc3RhcnQgPCBXT1JLX0lOVEVSVkFM
KjEwMDApOwogICAgdXNsZWVwKCgxMDAwLVdPUktfSU5URVJWQUwpKjEwMDApOwogIH0KfQoKCgpp
bnQgdGltZXJfcGlwZVsyXTsKI2RlZmluZSBUSU1FUl9FWFBJUlkgMHg1NQoKLyoKICogSW52b2tl
ZCBlYWNoIHRpbWUgdGhlIGl0aW1lciBleHBpcmVzCiAqLwp2b2lkIHRpbWVyX2hhbmRsZXIoaW50
IHNpZywgc2lnaW5mb190ICppbmZvLCB2b2lkICp1Y29udGV4dCkKewogIGNoYXIgbXNnID0gVElN
RVJfRVhQSVJZOwogIGludCByZXQgPSB3cml0ZSh0aW1lcl9waXBlWzFdLCAmbXNnLCBzaXplb2Yo
bXNnKSk7CiAgaWYgKHJldCAhPSAxKQogICAgcHJpbnRmKCJwaXBlIHdyaXRlIGZhaWxlZDogJXNc
biIsIHN0cmVycm9yKGVycm5vKSk7Cn0KCgp2b2lkICpjcmVhdGVfdGltZXJfdGhyZWFkKHZvaWQg
KmFyZykKewogIHN0cnVjdCBzaWdldmVudCBldmVudDsKICBzdHJ1Y3QgaXRpbWVyc3BlYyBpdGlt
ZTsKICB0aW1lcl90IHRpbWVyX2lkOwogIHNpZ3NldF90IHNldDsKICBzdHJ1Y3Qgc2lnYWN0aW9u
IHNhOwogIGludCByZXQ7CiAgZG91YmxlIGxhc3RfZXhwaXJ5OwoKICBwdGhyZWFkX3NldG5hbWVf
bnAocHRocmVhZF9zZWxmKCksICJ0aW1lcl90aHJlYWQiKTsKCiAgc3RydWN0IHNjaGVkX3BhcmFt
IHBhcmFtID0gey5zY2hlZF9wcmlvcml0eSA9IFRJTUVSX1BSSU9SSVRZfTsKICBpZiAoc2NoZWRf
c2V0c2NoZWR1bGVyKDAsIFNDSEVEX1JSLCAmcGFyYW0pID09IC0xKSB7CiAgICBwcmludGYoInRp
bWVyX3RocmVhZDogRmFpbGVkIHNjaGVkX3NldHNjaGVkdWxlcigpOiAlc1xuIiwgc3RyZXJyb3Io
ZXJybm8pKTsKICAgIHJldHVybiBOVUxMOwogIH0KCiAgLyogU2V0IHVwIHBpcGUgdG8gY29tbXVu
aWNhdGUgYmV0d2VlbiB0aW1lciBoYW5kbGVyIGFuZCB0aGlzIGZ1bmN0aW9uICovCiAgaWYgKHBp
cGUodGltZXJfcGlwZSkpCiAgICBwZXJyb3IoInBpcGUiKTsKCiAgZXZlbnQuc2lnZXZfbm90aWZ5
ID0gU0lHRVZfU0lHTkFMOwogIGV2ZW50LnNpZ2V2X3NpZ25vID0gU0lHUlRNSU4rMTsKICBldmVu
dC5zaWdldl9ub3RpZnlfYXR0cmlidXRlcyA9IE5VTEw7CiAgZXZlbnQuc2lnZXZfdmFsdWUuc2l2
YWxfcHRyID0gJnRpbWVyX2lkOwoKICBpZiAodGltZXJfY3JlYXRlKENMT0NLX1JFQUxUSU1FLCAm
ZXZlbnQsICZ0aW1lcl9pZCkpCiAgICBwZXJyb3IoInRpbWVyX2NyZWF0ZSIpOwoKICAvKiBTZXQg
dXAgc2lnbmFsIHRvIGJlIGhhbmRsZWQgYnkgdGhpcyB0aHJlYWQgKi8KICBzaWdlbXB0eXNldCgm
c2V0KTsKICBzaWdhZGRzZXQoJnNldCwgU0lHUlRNSU4rMSk7CiAgaWYgKChyZXQgPSBwdGhyZWFk
X3NpZ21hc2soU0lHX1VOQkxPQ0ssICZzZXQsIE5VTEwpKSAhPSAwKQogICAgcHJpbnRmKCJGYWls
ZWQgcHRocmVhZF9zaWdtYXNrKCk6ICVzXG4iLCBzdHJlcnJvcihyZXQpKTsKICBtZW1zZXQoJnNh
LCAwLCBzaXplb2Yoc2EpKTsKICBzYS5zYV9mbGFncyA9IFNBX1NJR0lORk87CiAgc2Euc2Ffc2ln
YWN0aW9uID0gdGltZXJfaGFuZGxlcjsKICBpZiAoc2lnYWN0aW9uKFNJR1JUTUlOKzEsICZzYSwg
TlVMTCkgPT0gLTEpCiAgICBwcmludGYoIkZhaWxlZCBzaWdhY3Rpb24oKTogJXNcbiIsIHN0cmVy
cm9yKGVycm5vKSk7CgogIGl0aW1lLml0X3ZhbHVlLnR2X3NlYyA9IDA7CiAgaXRpbWUuaXRfdmFs
dWUudHZfbnNlYyA9IEtIWigyKTsKICBpdGltZS5pdF9pbnRlcnZhbC50dl9zZWMgPSAwOwogIGl0
aW1lLml0X2ludGVydmFsLnR2X25zZWMgPSBLSFooMik7CiAgdGltZXJfc2V0dGltZSh0aW1lcl9p
ZCwgMCwgJml0aW1lLCBOVUxMKTsKCiAgbGFzdF9leHBpcnkgPSBjdXJyZW50X3RpbWVfZG91Ymxl
KCk7CiAgZm9yICg7OykgewogICAgY2hhciBtc2c7CiAgICBpbnQgYnl0ZXNfcmVhZCA9IHJlYWQo
dGltZXJfcGlwZVswXSwgJm1zZywgc2l6ZW9mKG1zZykpOwoKICAgIGlmIChieXRlc19yZWFkID09
IC0xICYmIGVycm5vID09IEVJTlRSKQogICAgICAgIGNvbnRpbnVlOwogICAgZWxzZSBpZiAoYnl0
ZXNfcmVhZCAhPSAxKSB7CiAgICAgIHByaW50ZigiUmVhZCBlcnJvciwgYnl0ZXNfcmVhZD0lZCAo
JXMpXG4iLCBieXRlc19yZWFkLCBzdHJlcnJvcihlcnJubykpOwogICAgICBleGl0KDEpOwogICAg
fQogICAgaWYgKG1zZyA9PSBUSU1FUl9FWFBJUlkpIHsKICAgICAgZG91YmxlIGN1cl90aW1lID0g
Y3VycmVudF90aW1lX2RvdWJsZSgpOwogICAgICBpZiAoY3VyX3RpbWUgLSBsYXN0X2V4cGlyeSA+
IDEwMDApCiAgICAgICAgcHJpbnRmKCJkZWxheWVkIHRpbWVyIGV4cGlyeSAlZlxuIiwgY3VyX3Rp
bWUgLSBsYXN0X2V4cGlyeSk7CiAgICAgIGxhc3RfZXhwaXJ5ID0gY3VyX3RpbWU7CiAgICB9IGVs
c2UKICAgICAgcHJpbnRmKCJVbmtub3duIG1lc3NhZ2U6ICVoaHVcbiIsIG1zZyk7CiAgfQoKfQoK
aW50IG1haW4odm9pZCkKewogIHNpZ3NldF90IHNldDsKICBpbnQgcmV0OwogIHB0aHJlYWRfdCB3
b3JrZXJzW1dPUktFUlNdOwogIHB0aHJlYWRfdCB0aW1lcl90aWQ7CiAgdW5zaWduZWQgbG9uZyBp
OwoKICBzcmFuZG9tKChpbnQpY3VycmVudF90aW1lX2RvdWJsZSgpKTsKCiAgLyogQmxvY2sgU0lH
UlRNSU4rMSB0byBhbGwgdGhyZWFkcyAtIHVuYmxvY2sgbGF0ZXIgaW4gdGltZXIgdGhyZWFkICov
CiAgc2lnZW1wdHlzZXQoJnNldCk7CiAgc2lnYWRkc2V0KCZzZXQsIFNJR1JUTUlOKzEpOwogIGlm
ICgocmV0ID0gcHRocmVhZF9zaWdtYXNrKFNJR19CTE9DSywgJnNldCwgTlVMTCkpICE9IDApCiAg
ICBwcmludGYoIkZhaWxlZCBzaWdtYXNrKCk6ICVzXG4iLCBzdHJlcnJvcihyZXQpKTsKCiAgZm9y
IChpID0gMDsgaSA8IFdPUktFUlM7IGkrKykKICAgIGlmICgocmV0ID0gcHRocmVhZF9jcmVhdGUo
JndvcmtlcnNbaV0sIE5VTEwsIHdvcmtlcl9mdW5jLCAodm9pZCAqKWkpKSAhPSAwKSB7CiAgICAg
IGVycm5vID0gcmV0OwogICAgICBwZXJyb3IoInB0aHJlYWRfY3JlYXRlKHdvcmtlcikiKTsKICAg
IH0KCiAgLyogTm93IGNyZWF0ZSB0aW1lciB0aHJlYWQgKi8KICBpZiAoKHJldCA9IHB0aHJlYWRf
Y3JlYXRlKCZ0aW1lcl90aWQsIE5VTEwsIGNyZWF0ZV90aW1lcl90aHJlYWQsIE5VTEwpKSAhPSAw
KSB7CiAgICBlcnJubyA9IHJldDsKICAgIHBlcnJvcigicHRocmVhZF9jcmVhdGUodGltZXIpIik7
CiAgfQoKICAvL3NsZWVwKDMwKTsKICBwYXVzZSgpOwogIHJldHVybiAwOwp9Cg==
--0000000000005dd48305fecf2595--
