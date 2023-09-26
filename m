Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CD01FA1
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 16:45:21 +0000 (UTC)
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CBD12A
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 09:45:18 -0700 (PDT)
Received: from [10.172.66.188] (1.general.jsalisbury.us.vpn [10.172.66.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id EDC5644049
	for <linux-rt-users@vger.kernel.org>; Tue, 26 Sep 2023 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1695746716;
	bh=7wB2bRIlkg38esZ3Akwbl+5gp1Sop+bRJKndvdzP3Aw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type;
	b=oJ+zZrCRlrziFJPPGcfaCxU+bTk1jY3frG8S5HqWmX1ov3xXyqQAyvSRvHcRkY1p+
	 U6N7sWhAs7s8nFqnAcLTZu3Z6F3sUf7+Sed13smhS9jE53Av8+pPEL7lFRB0siWhQH
	 VPUf2rMmkAr7JmPThyPeXYvMlOT0L2xYijTid9hEr8CMq/vjySBH+fpcUe7Xrbs+wm
	 P+3XF+NKcrbA+c9+h4/kBtJU57oq7MrScgoZxsE+9Us2RnfrxlBucDhnpxVVrwSpzW
	 BFp1KdLF1kgMzqPx+sYNCQjqqyduUwWHLtkwQNWRN7yBd+0f1J2zjjZbQog+hZxvsY
	 znZnKtypLfsOg==
Message-ID: <5afe86b4-bae3-2fa8-ec33-9686d3c18255@canonical.com>
Date: Tue, 26 Sep 2023 12:45:14 -0400
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
From: Joseph Salisbury <joseph.salisbury@canonical.com>
Subject: Question Regarding isolcpus
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi All,

I have a question regarding the isolcpus parameter.  I've been seeing 
this parameter commonly used. However, in the kernel.org 
documentation[0], isolcpus is listed as depreciated.

Is it the case that isolcpus should not be used at all?  I've seen it 
used in conjunction with taskset.  However, should we now be telling rt 
users to use only cpusets in cgroups?  I see that CPUAffinity can be set 
in /etc/systemd/system.conf.  Is that the preferred method, so the 
process scheduler will automatically migrate processes between the 
cpusets in the cgroup cpuset or the list set by CPUAffinity?

I'm sure there are some presentations or papers on this, so I'll dig 
around as well :-)

Thanks,

Joe


[0] 
https://www.kernel.org/doc/html/v5.15/admin-guide/kernel-parameters.html#:~:text=Deprecated%20%2D%20use%20cpusets%20instead 

