## BUFFER POOL

#### 1. LRU REPLACEMENT POLICY
```c++
class LRUReplacer : public Replacer 
```
Public 继承 `Replacer`
##### Function

- Victim : 从跟踪中的块中挑出一个移除
- Unpin: Replacer开始跟踪frame_id的块 
- Pin: 从Replacer的跟踪中移除

##### 设计

采用 map + list 的设计






#### 2. BUFFER POOL MANAGER INSTANCE
#### 3. PARALLEL BUFFER POOL MANAGER











