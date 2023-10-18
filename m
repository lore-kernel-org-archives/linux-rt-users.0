Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9958615AE2
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Oct 2023 09:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="MtD6/lI1"
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43A6F7;
	Wed, 18 Oct 2023 02:50:59 -0700 (PDT)
Received: from localhost (styx2022 [192.168.200.17])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id 6F249433F8;
	Wed, 18 Oct 2023 11:50:57 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Authentication-Results: styx2022.feld.cvut.cz (amavisd-new);
	dkim=pass (2048-bit key) header.d=fel.cvut.cz
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
	by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
	with ESMTP id yeVaz1NCRDon; Wed, 18 Oct 2023 11:50:55 +0200 (CEST)
Received: from k135-p197.felk.cvut.cz (unknown [147.32.86.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id E37064357C;
	Wed, 18 Oct 2023 11:50:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1697622655;
	bh=qTZDMjf/40RpDBlOk6biXIHCUslQNCwjZp5SL/wPv/A=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=MtD6/lI14PUO+Aewa9ZbU3BF+S50AjPTxjcpSBozLI0pmX3VcKdXRNbBaOKAQTUam
	 HlaG4Lo+oxCh1tP40mhndj6VQxyJwhQ4jCWkAssCTPz9Osk8Kcd+W4XOxyTDd96dj9
	 MWYHmW1EDllc6KUOqo5s6kwScy1kwU73qExMRmOyfLiXOgF/RegN38EUJK7cb7J6F9
	 Ik5+Oa7r75Js5H3qTmx9x6cKi7MpcD3gc96gt5DVw76wvgeaLlhwqvrm5e0UOQqL0s
	 sxyuuH8K+T9R5+SC/Z/6ya74qggse/zJgtlpNgOz7Fi8zdbC6eE5V10PiAAsv1eCMv
	 nKoCZVdFa+5JQ==
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Outstanding latency increase in kernel CAN gateway caught by CANlatester daily builds at 2023-10-02
Date: Wed, 18 Oct 2023 11:50:56 +0200
User-Agent: KMail/1.9.10
Cc: linux-can@vger.kernel.org,
 linux-rt-users@vger.kernel.org,
 Ondrej Ille <ondrej.ille@gmail.com>,
 =?utf-8?q?Mat=C4=9Bj_Vasilevski?= <matej.vasilevski@gmail.com>,
 Pavel Hronek <hronepa1@fel.cvut.cz>,
 =?utf-8?q?Ji=C5=99=C3=AD_Nov=C3=A1k?= <jnovak@fel.cvut.cz>,
 Carsten Emde <c.emde@osadl.org>,
 Jan Altenberg <Jan.Altenberg@osadl.org>
References: <202310021040.49367.pisa@fel.cvut.cz> <383f33ac-3254-4277-a9a9-8f7104851d49@hartkopp.net>
In-Reply-To: <383f33ac-3254-4277-a9a9-8f7104851d49@hartkopp.net>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202310181150.56364.pisa@fel.cvut.cz>
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Oliver,

On Saturday 14 of October 2023 12:57:53 Oliver Hartkopp wrote:
> Hello Pavel,
>
> is there any news on this latency issue?
>
> I've not seen any can-gw related changes between 6.2 and 6.6.
>
> The only change for linux/net/can/gw.c is this patch:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
>id=2a30b2bd01c23a7eeace3a3f82c2817227099805

I am keeping eye on the results daily and it seems that run

run-231002-045216-hist+6.6.0-rc3-rt5-ge31516c1e553+flood-kern-prio-fd-load

https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&load=1&flood=1&fd=1&prio=1&kern=1

is really outlayer. At the end it is single one, I have
interpretted the graph incorrectly because so much outstanding
value at the end looked as flat increase covering two consecutive
runs.

So the kernel GW average and maximas follow previous trend
after this single peak. So the peak could be related to some
transitional state in RT development causing some problem
with priorities etc., or can be result of some other problems
in the whole setup. I am analyzing some problems with
lost messages in some cases of RT runs which seems
to be related more to some problem in testing system,
setup before run, FPGA reload etc. which cause bus error
or something similar with initial suspicion on monitoring
side problem. But I do not have conclusion yet.

Published runs are complete with no message lost
and statistic/trends seems to be without significant
change from start of the measurement in May.
The change/increase of trends before May has well understood
reason, we have updated stress testing, include more sources
and tuned priorities for user GW etc...
In alonger term perspective, initial setup testing data from
April should/will be removed/masked from public data to not
provide false assumptions. We probably start new series
when 2024 year starts. We will see how data capacity
and viewing will work work and slower as data set is extended.

If I notice some significant change in more consecutive runs,
I try to check it and send information.
In the fact, we have caught one real problem in RT
already.

Best wishes,

                Pavel
--
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home
