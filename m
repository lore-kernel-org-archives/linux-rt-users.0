Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31FC8CE
	for <linux-rt-users@vger.kernel.org>; Wed,  7 Jan 2026 22:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767826494; cv=none; b=XsHuvxXqImNQRlRLWAEtP+xbCnIiPqzrVKUmv3+hfq/o41A3HXWqfxONkorPipNWy2RLZls/Bh0ecRhqPHi0FvMUKBcMtxnOPMZr0sglu5QhSuTygR6r6FPmFdFa7HEd89OlAk0vuq+BwLmyjKIbR2socM5gDO776d8XrQE7S/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767826494; c=relaxed/simple;
	bh=3uNq7cCguG1HowieGFeMMAJVy8gugIWOKvjlsax3odA=;
	h=Date:From:To:Cc:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nWbNmUQFVfxHG5IrG+amGqoCvZAeyT181FHuBkd2TVHyBzgqwsC7KIogb5G+Id21+d5t3tZyLq3wBJVBHAvt85EnJaKFVNfsjv0MpuseeOzK3FY11+tIrUamJFizsJECe3Ms9cZZ6I1n6F7fVJKIK8Hm2a+E7y10HkxUtALYaII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhDRQaYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhDRQaYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 310B8C4CEF1;
	Wed,  7 Jan 2026 22:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767826494;
	bh=3uNq7cCguG1HowieGFeMMAJVy8gugIWOKvjlsax3odA=;
	h=Date:From:To:Cc:From;
	b=uhDRQaYP0SN/UUZpXq8ArxhPmUlLvTQNa3sd7LngPgxviiuUPTb6EurNvzs8Hlk9p
	 p8q26siLtg8hajbU0YeXtYw++2r51+wE50hsiB9o3o8jDEY9EEGt7G8qTcwHnlILpy
	 Du+v07J3uQyoVCfiRV2RSFKKgAi4Dt+IjhI3wn04Zq1NIZFGxLGhkEgcc2SEP8rBxV
	 onewdzaAjt7zPamM3BbaE4uhnONhzWAbVge/9MBpnrQkZU1gTLwQT48y+461DWSKXH
	 zRBIDEsV4ZybXeSXKu3+RuXeOXGYRJEL8Ku+V9/j4nk0czWXE9E1xNBT7I1bhntEy7
	 SLJTpCWj0coMA==
Date: Wed, 7 Jan 2026 16:54:52 -0600
From: Clark Williams <clrkwllms@kernel.org>
To: linux-rt-users@vger.kernel.org
Cc: David Abdurachmanov <davidlt@rivosinc.com>, luffyluo@lysander
Message-ID: <aV7kPP8QkU-rZ4G2@lysander>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

<luffyluo@tencent.com>, Wander Lairson Costa <wander@redhat.com>
Bcc: 
Subject: [ANNOUNCE] stalld v1.26.1 released
Reply-To: 

  Hi all,                                                                     
                                                                              
  I'm pleased to announce the release of stalld v1.26.1, now available        
  at kernel.org, GitLab, and GitHub.                                          
                                                                              
  Overview                                                                    
                                                                              
  This release focuses on build system improvements, adding RISC-V            
  64-bit architecture support and enhancing cross-platform compatibility      
  through better compiler flag detection.                                     
                                                                              
  New Architecture Support                                                    
                                                                              
  RISC-V 64-bit (riscv64)                                                     
  - stalld can now be built for RISC-V 64-bit systems                         
  - Adds to existing support for x86_64, aarch64, s390x, i686, and            
    powerpc/ppc64le                                                           
                                                                              
  Build System Improvements (Wander Lairson Costa)                            
                                                                              
  Compiler Flag Detection                                                     
  - Added feature detection for -mno-omit-leaf-frame-pointer, fixing          
    builds on s390x and older compilers                                       
  - Improved -fcf-protection detection using direct compiler testing          
    instead of GCC version checks                                             
  - Removed redundant GCC version check, simplifying the Makefile             
                                                                              
  Build Process                                                               
  - BPF tool versions (kernel, clang, bpftool) now printed during build       
    for easier debugging of compilation issues                                
  - Explicit 'test' target in tests directory for clearer build process       
                                                                              
  Bug Fixes                                                                   
                                                                              
  - Fixed typo: renamed 'merge_taks_info' to 'merge_tasks_info'               
  - Updated .gitignore to exclude development tool metadata                   
                                                                              
  Download                                                                    
                                                                              
  - https://git.kernel.org/pub/scm/utils/stalld/stalld.git                    
  - https://gitlab.com/rt-linux-tools/stalld                                  
  - https://github.com/clrkwllms/stalld                                       
                                                                              
  git tag: v1.26.1                                                            
                                                                              
  Contributors                                                                
                                                                              
  - David Abdurachmanov                                                       
  - luffyluo                                                                  
  - Wander Lairson Costa                                                      
  - Clark Williams                                                            
                                                                              
  Full release notes: doc/RELEASE_NOTES_v1.26.1.md                            
                                                                              
  Best regards,                                                               
  Clark Williams                                                              

-- 
The United States Coast Guard
Ruining Natural Selection since 1790
