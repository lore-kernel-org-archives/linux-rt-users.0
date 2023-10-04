Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0615CF
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Oct 2023 06:33:37 +0000 (UTC)
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70956AF
	for <linux-rt-users@vger.kernel.org>; Tue,  3 Oct 2023 23:33:36 -0700 (PDT)
Received: from [IPV6:2a01:e0a:244:b080:a267:71a:64f0:86b8] (unknown [IPv6:2a01:e0a:244:b080:a267:71a:64f0:86b8])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 8349860149
	for <linux-rt-users@vger.kernel.org>; Wed,  4 Oct 2023 08:33:34 +0200 (CEST)
Message-ID: <95ddebbf-25cf-d692-17f4-a7ecaceb9f6f@free.fr>
Date: Wed, 4 Oct 2023 08:33:34 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: linux-rt-users@vger.kernel.org
From: Yann Collette <ycollette.nospam@free.fr>
Subject: rt-tests build failure on Fedora 39 with Python 3.12
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,


Rt-tests fails to build on Fedora 39 with python 3.12. The distutils 
module has been removed from python 3.12.

Is there a place where I can report the problem ?


Best regards,


Yann

