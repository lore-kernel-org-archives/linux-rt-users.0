Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E400C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FE9E6115B
	for <linux-rt-users@archiver.kernel.org>; Tue,  9 Nov 2021 07:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbhKIHDd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 9 Nov 2021 02:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243369AbhKIHDc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Nov 2021 02:03:32 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 144B0C061764
        for <linux-rt-users@vger.kernel.org>; Mon,  8 Nov 2021 23:00:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y7so2178934plp.0
        for <linux-rt-users@vger.kernel.org>; Mon, 08 Nov 2021 23:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JXErBuD3aVLS+BWYPN95mHG1yshVK/TeM2z5xsXOEJE=;
        b=Ijczyyuc4IWFdio2HTGz7dojiVDmT7AcPEP87OoJGl9u6SCKtVtpe7Mx+TrWdo9yJY
         MtjMTAbKlguVzf8MQQpXhQJK/mpsqaQGgJPdK5T1ElcTLQHFs4v97HJPiStpVPK/2kt3
         J+6S/q93T4i7xdzvoniFQtTmlha7s3abi7rcGCErilO09SbKldAdNhEkzI4GeCwswtvQ
         KIMyqMg3ymwlFmqdkqtOeG632xDiAmtDN8KuczOrJQjkqFPxZ9eqJUpOHVpLT6a8NSJ9
         W09yjt4kHs3ZN+P0ZdqkJkM1lQA2ldQ4NzHwtNhwKhplp/xTvqdxkiDbl7RelqdjsxCN
         7I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=JXErBuD3aVLS+BWYPN95mHG1yshVK/TeM2z5xsXOEJE=;
        b=fhrn/B+kyH1iyzxs0yhc2poSyBsrTJSFs7ZreIoR4wsn7bCT6HSJ7+bGcTL2tPfChD
         wscAhI+6JWy/uYVTDe4/SjX/X73W9HeK/R9xw5Lv3zJe8DS9q6BARl0yhHA/IP5TkE0H
         7hF3h3jdw6YTV/C/WsNsoRzAvU3IRA08wmJ5Kc+Jbha1IwgtvFgOlDLigKzgQBjss31o
         1kR1+LbrXIlB4Mggc+aBRN0a5YgnchUte+4LJl7LBXDW38U5PJNpqCIonI+G2mPTUBL9
         wLE4TlzSRv5CkKlC9nt5F5MpInbH1FM7rk/kjvHXcpDKzl31sdthLyAo1IDA85+3VPYk
         NANg==
X-Gm-Message-State: AOAM532I+CJObhrULkJNhBWO9wAXljCI/yTVrRrtSjUs7o6N6fxoRJu4
        7Pvj1SWARS32XKgV2ciDupY=
X-Google-Smtp-Source: ABdhPJxffTh7reP4yhbMa/FBcwEbC28FnnloQyR2oye5gUSDDYFG1yllw5ivMjuNsJnZ+SqWQIShzA==
X-Received: by 2002:a17:902:ecca:b0:141:e920:3b71 with SMTP id a10-20020a170902ecca00b00141e9203b71mr4782960plh.10.1636441246568;
        Mon, 08 Nov 2021 23:00:46 -0800 (PST)
Received: from localhost (122x211x248x161.ap122.ftth.ucom.ne.jp. [122.211.248.161])
        by smtp.gmail.com with ESMTPSA id o4sm1347930pjq.23.2021.11.08.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 23:00:46 -0800 (PST)
From:   Punit Agrawal <punitagrawal@gmail.com>
To:     jkacur@redhat.com
Cc:     linux-rt-users@vger.kernel.org, punit1.agrawal@toshiba.co.jp
Subject: Re: [PATCH v2 1/3] rteval: cyclictest.py Enable logging cyclictest
 output
References: <20210917085343.2775300-1-punitagrawal@gmail.com>
        <20210917085343.2775300-2-punitagrawal@gmail.com>
        <87a6idak7b.fsf@stealth>
Date:   Tue, 09 Nov 2021 16:00:43 +0900
In-Reply-To: <87a6idak7b.fsf@stealth> (Punit Agrawal's message of "Tue, 09 Nov
        2021 15:59:04 +0900")
Message-ID: <871r3pak4k.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Punit Agrawal <punitagrawal@gmail.com> writes:

> Punit Agrawal <punitagrawal@gmail.com> writes:
>
>> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>>
>> The cyclictest.py module uses a temporary file to store the output
>> from "cyclictest" which is deleted at the end of the run. As the
>> collected log contains information that can be useful for development
>> or debugging, having the ability to persist the logs is useful.
>>
>> With this goal, introduce a configuration option for the cyclictest.py
>> module, "savelogs", that can be used to enable persisting the
>> cyclictest output to a logfile. As the logs an be quite large, the
>> default is to not save them.
>>
>> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
>> ---
>>  rteval/modules/measurement/cyclictest.py | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/rteval/modules/measurement/cyclictest.py b/rteval/modules/measurement/cyclictest.py
>> index b1755d4f4421..ee1de883d844 100644
>> --- a/rteval/modules/measurement/cyclictest.py
>> +++ b/rteval/modules/measurement/cyclictest.py
>> @@ -197,6 +197,8 @@ class Cyclictest(rtevalModulePrototype):
>>          self.__numanodes = int(self.__cfg.setdefault('numanodes', 0))
>>          self.__priority = int(self.__cfg.setdefault('priority', 95))
>>          self.__buckets = int(self.__cfg.setdefault('buckets', 2000))
>> +        self.__reportdir = self.__cfg.setdefault('reportdir', os.getcwd())
>> +        self.__save_logs = self.__cfg.setdefault('savelogs', False)
>>          self.__numcores = 0
>>          self.__cpus = []
>>          self.__cyclicdata = {}
>> @@ -255,6 +257,8 @@ class Cyclictest(rtevalModulePrototype):
>>          mounts.close()
>>          return ret
>>  
>> +    def _open_logfile(self, name):
>> +        return open(os.path.join(self.__reportdir, "logs", name), 'w+b')
>>  
>>      def _WorkloadSetup(self):
>>          self.__cyclicprocess = None
>> @@ -288,7 +292,10 @@ class Cyclictest(rtevalModulePrototype):
>>              self.__cmd.append("--tracemark")
>>  
>>          # Buffer for cyclictest data written to stdout
>> -        self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
>> +        if self.__save_logs:
>> +            self.__cyclicoutput = self._open_logfile('cyclictest.stdout')
>> +        else:
>> +            self.__cyclicoutput = tempfile.SpooledTemporaryFile(mode='w+b')
>>  
>>  
>>      def _WorkloadTask(self):
>
> Ping!
>
> This patch was missed when reviewing / merging the other patches in the
> series.

*Argh* - this is an older version. Please ignore.
I'll highlight the correct version in a separate message.
