package com.system.utils;

import com.dyuproject.protostuff.LinkedBuffer;
import com.dyuproject.protostuff.ProtostuffIOUtil;
import com.dyuproject.protostuff.runtime.RuntimeSchema;

/**
 * 序列化工具类：通过ProtoStuff实现（只能实例化 POJO 对象，即有 get、set 方法的对象）
 * @author HandyZcy
 *
 */
public class SerializerUtil_Protostuff {

	/**
	 * 序列化对象
	 * @param obj
	 * @return
	 */
	public static <T> byte[] serialize(T obj){
		try {
			@SuppressWarnings("unchecked")
			Class<T> cls = (Class<T>) obj.getClass();
			RuntimeSchema<T> schema = RuntimeSchema.createFrom(cls);
			byte[] bytes = ProtostuffIOUtil.toByteArray(obj, schema, LinkedBuffer.allocate(LinkedBuffer.DEFAULT_BUFFER_SIZE));
			return bytes;
		} catch (Exception e) {
			throw new RuntimeException("序列化失败!", e);
		}
	}
	
	/**
	 * 反序列化对象
	 * @param bytes 字节数组
	 * @param cls cls
	 * @return
	 */
	public static <T> T deserialize(byte[] bytes, Class<T> cls){
		try {
			RuntimeSchema<T> schema = RuntimeSchema.createFrom(cls);
			T message = schema.newMessage();
			ProtostuffIOUtil.mergeFrom(bytes, message, schema);
			return message;
		} catch (Exception e) {
			throw new RuntimeException("反序列化失败!", e);
		}
	}
}
