Received: from smtp205-pc.aruba.it (smtp205-pc.aruba.it [62.149.157.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2A77104
	for <linux-rt-users@vger.kernel.org>; Tue, 18 Jun 2024 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.157.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718705863; cv=none; b=RB0PHuLFY6IxndFQXXHH76GXriBP7SU6QQtLVIe6l4L0Y1tZBExTdIOGYYwbCbONxItJ90TTlPwbNbHQyIgeKiVTnmXcfR8hd+SLu8j0FlI/x93OICVKjBW4sOCxXSGmXOYJrOA/cNLzw9ZMtArE/ZeXFMWtcviUVXwdI18qrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718705863; c=relaxed/simple;
	bh=XspEqLfVuQSI7ignUrwKmCQh3hRatjlVo/N0zeZiZVw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=bBNbCxN5yYv7+vPCUksMXOZVvCG7SWlUeZBR5S3OW2AardcWwG68szuS+eHrX3aXdpSHpCOBHzBe5cKWgYlcHbOeWSMV3f3iKe6kK3xJxqy+urUOQgAVxByyc6K/1cBmSEybyaImO7Sf44pMwzqzb3KFOC8B0VfplNrvbbjDTJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leaff.it; spf=none smtp.mailfrom=leaff.it; dkim=pass (2048-bit key) header.d=leaff.it header.i=@leaff.it header.b=fTvUR+VT; arc=none smtp.client-ip=62.149.157.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=leaff.it
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=leaff.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leaff.it header.i=@leaff.it header.b="fTvUR+VT"
Received: from [192.168.99.128] ([45.82.133.163])
	by Aruba BMail Outgoing Smtp  with ESMTPSA
	id JVrBsd9FnVYqaJVrCs7t2P; Tue, 18 Jun 2024 12:14:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leaff.it; s=a1;
	t=1718705670; bh=XspEqLfVuQSI7ignUrwKmCQh3hRatjlVo/N0zeZiZVw=;
	h=Date:MIME-Version:To:From:Subject:Content-Type;
	b=fTvUR+VTjN6WK/W+wpz/1aqzHTaTgsKHcR3w0x+T+j6wI7n9mOknoecmDcmag670X
	 s89hZypNtoG2Ll9WGgMKLyYna0bViXJ58t4f5TSRQZLmkQ0QbOjE5RkA/c9V6Jal+K
	 EjSLRKk83eAb15KO3+zhG/zcAF0/25RhBkxlbVdPaxX0bGNdfVTeEgTWiKWvosfiKQ
	 cY8kNSsOCf2pQSNJMBuu2UgbuDFX4MQ24SRIqV1z16mv2oZBauKoLBupHsoQjw6XHV
	 r6OsqXeHn7Xsj5HWiGZbP6IswR8PQvrYEaj4AAdbqDmpjM9m/Bvx9baYDCsSRiHYQ+
	 KU7cWP5rw2+bw==
Message-ID: <e0fda694-ed7e-4f88-980b-f8a955ede802@leaff.it>
Date: Tue, 18 Jun 2024 12:14:29 +0200
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-rt-users@vger.kernel.org
From: Riccardo Laiolo <laiolo@leaff.it>
Content-Language: en-US, it-IT
Subject: Kernel instability using Marvell mv88e6xxx DSA
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKI591Xx5Hgi3c0JJALTjzlOJSsKmT7pxGdT2Zkg5DMbfJtpi9UcTvAWrMfCNcdc7h54MBDWeiexI8Ykgn6Sl0Z85Jnmp65EUA0eBPsefNoP/pLNauFO
 xBZ7L27QuY/plYZDUJjL2p9Pa5DLRxU4h0lV+8ZzzRbe5eGCGMqtGgEka9K1Joa/CvOMvVXUMp+30E8boj9lTU2cuEhsBzwQNGc=

Hi all,

I'm working on a custom board with an NXP iMX8MP cpu (linux 6.1.55-rt16 
from NXP's yocto repository).

The hardware is similar to the NXP evk. The main difference is the dsa 
switch (marvell MV88E6390).

If I enable the marvell's DT node the system becomes unstable. I have 
random kernel panics.

The error trace is not helpful, it looks like a stack overflow or a 
stack corruption. Sometimes it's a NULL (or random unallocated address) 
pointer dereference, but sometimes the error is different, I've seen an 
error about killing the idle task a couple of times. What seems constant 
is that the error occurs during the scheduler context switch after an 
hard interrupt.

How can I troubleshoot this kind of issues?

